/* ── Anchor navigation ──────────────────────────────────────────── */
(() => {
  const prevBtn = document.getElementById("anchor-prev");
  const nextBtn = document.getElementById("anchor-next");
  const prevLabel = prevBtn?.querySelector(".anchor-nav__label");
  const nextLabel = nextBtn?.querySelector(".anchor-nav__label");
  if (!prevBtn || !nextBtn || !prevLabel || !nextLabel) {
    return;
  }

  prevBtn.dataset.label = prevLabel.textContent || "";
  nextBtn.dataset.label = nextLabel.textContent || "";

  const getAnchors = () => Array.from(document.querySelectorAll(".manual-sheet h1[id], .manual-sheet h2[id], .manual-sheet h3[id], .manual-sheet h4[id]")).filter(Boolean);

  const setButtonLabel = (btn, labelNode, nextValue) => {
    const label = (nextValue || "").trim();
    if ((btn.dataset.label || "") === label) {
      return;
    }

    const prefersReduced = window.matchMedia("(prefers-reduced-motion: reduce)").matches;
    if (prefersReduced) {
      labelNode.textContent = label;
      btn.dataset.label = label;
      return;
    }

    const startHeight = btn.getBoundingClientRect().height;
    btn.style.height = `${startHeight}px`;
    btn.classList.add("is-morphing");

    requestAnimationFrame(() => {
      labelNode.textContent = label;
      btn.dataset.label = label;
      const endHeight = btn.scrollHeight;
      btn.style.height = `${endHeight}px`;
    });

    const cleanup = (event) => {
      if (event.propertyName !== "height") {
        return;
      }
      btn.style.removeProperty("height");
      btn.classList.remove("is-morphing");
      btn.removeEventListener("transitionend", cleanup);
    };

    btn.addEventListener("transitionend", cleanup);
  };

  const labelForAnchor = (el) => {
    if (!el) {
      return "";
    }
    return (el.textContent || "").replace(/\s+/g, " ").trim();
  };

  const goToAnchor = (el) => {
    if (!el || !el.id) {
      return;
    }
    const prefersReduced = window.matchMedia("(prefers-reduced-motion: reduce)").matches;
    const scrollTarget = (el.tagName === "H1" && el.closest(".manual-sheet")) ? el.closest(".manual-sheet") : el;
    scrollTarget.scrollIntoView({ behavior: prefersReduced ? "auto" : "smooth", block: "start" });
    history.replaceState(null, "", `#${el.id}`);
  };

  const currentIndex = (anchors) => {
    const triggerLine = 140;
    let idx = -1;
    for (let i = 0; i < anchors.length; i += 1) {
      if (anchors[i].getBoundingClientRect().top <= triggerLine) {
        idx = i;
      } else {
        break;
      }
    }
    return idx;
  };

  const refreshState = () => {
    const desktop = window.matchMedia("(min-width: 901px)").matches;
    if (!desktop) {
      prevBtn.disabled = true;
      nextBtn.disabled = true;
      setButtonLabel(prevBtn, prevLabel, "Previous section");
      setButtonLabel(nextBtn, nextLabel, "Next section");
      prevBtn.dataset.targetId = "";
      nextBtn.dataset.targetId = "";
      return;
    }

    const anchors = getAnchors();
    const idx = currentIndex(anchors);
    const prevTarget = idx > 0 ? anchors[idx - 1] : null;
    const nextTarget = idx < anchors.length - 1 ? anchors[idx + 1] : (idx === -1 ? anchors[0] : null);

    prevBtn.disabled = false;
    nextBtn.disabled = !nextTarget;
    prevBtn.dataset.targetId = prevTarget ? prevTarget.id : "--top--";
    nextBtn.dataset.targetId = nextTarget ? nextTarget.id : "";
    setButtonLabel(prevBtn, prevLabel, prevTarget ? labelForAnchor(prevTarget) : "Start");
    setButtonLabel(nextBtn, nextLabel, nextTarget ? labelForAnchor(nextTarget) : "End");
    prevBtn.setAttribute("aria-label", prevTarget ? `Go to ${labelForAnchor(prevTarget)}` : "Go to cover page");
    nextBtn.setAttribute("aria-label", nextTarget ? `Go to ${labelForAnchor(nextTarget)}` : "No next section");
  };

  let refreshQueued = false;
  const scheduleRefresh = () => {
    if (refreshQueued) {
      return;
    }
    refreshQueued = true;
    requestAnimationFrame(() => {
      refreshQueued = false;
      refreshState();
    });
  };

  prevBtn.addEventListener("click", () => {
    if (prevBtn.dataset.targetId === "--top--") {
      const prefersReduced = window.matchMedia("(prefers-reduced-motion: reduce)").matches;
      window.scrollTo({ top: 0, behavior: prefersReduced ? "auto" : "smooth" });
      history.replaceState(null, "", window.location.pathname);
      return;
    }
    const target = document.getElementById(prevBtn.dataset.targetId || "");
    goToAnchor(target);
  });

  nextBtn.addEventListener("click", () => {
    const target = document.getElementById(nextBtn.dataset.targetId || "");
    goToAnchor(target);
  });

  window.addEventListener("scroll", scheduleRefresh, { passive: true });
  window.addEventListener("resize", scheduleRefresh);
  window.addEventListener("load", scheduleRefresh);
  scheduleRefresh();
})();

/* ── Figure & table auto-numbering ─────────────────────────────── */
var figMap = {};
var figCount = 0;
document.querySelectorAll('.manual-sheet img[alt]').forEach(function(img) {
  if (!img.alt) return;
  figCount++;
  var figure = document.createElement('figure');
  var caption = document.createElement('figcaption');
  caption.textContent = 'Figure ' + figCount + ': ' + img.alt;
  if (img.id) {
    figMap[img.id] = figCount;
    figure.id = img.id;
    img.removeAttribute('id');
  }
  img.parentNode.insertBefore(figure, img);
  figure.appendChild(img);
  figure.appendChild(caption);
});
document.querySelectorAll('a.figref').forEach(function(a) {
  var id = (a.getAttribute('href') || '').replace(/^#/, '');
  if (figMap[id] !== undefined) {
    a.textContent = 'Figure ' + figMap[id];
  }
});
var tblMap = {};
var tblCount = 0;
document.querySelectorAll('.manual-sheet table').forEach(function(tbl) {
  tblCount++;
  if (tbl.id) {
    tblMap[tbl.id] = tblCount;
  }
  var prev = tbl.previousElementSibling;
  if (prev && prev.classList.contains('table-caption')) {
    prev.textContent = 'Table ' + tblCount + '. ' + prev.textContent.replace(/^Table\s+\d+[.:]\s*/i, '');
  }
});
document.querySelectorAll('a.tblref').forEach(function(a) {
  var id = (a.getAttribute('href') || '').replace(/^#/, '');
  if (tblMap[id] !== undefined) {
    a.textContent = 'Table ' + tblMap[id];
  }
});

/* ── Slideshow auto-numbering & slide navigation ─────────────────── */
var sldMap = {};
var sldCount = 0;
document.querySelectorAll('.manual-sheet [data-slideshow]').forEach(function(wrap) {
  if (!wrap.id) return;
  sldCount++;
  sldMap[wrap.id] = sldCount;
});
document.querySelectorAll('a.sldref').forEach(function(a) {
  var href = a.getAttribute('href') || '';
  var id = href.replace(/^#/, '');
  var slide = a.dataset.slide ? parseInt(a.dataset.slide, 10) : null;
  var num = sldMap[id];
  if (num === undefined) return;
  a.textContent = slide ? 'Slideshow\u00a0' + num + ',\u00a0Step\u00a0' + slide : 'Slideshow\u00a0' + num;
});
document.querySelectorAll('a.sldref').forEach(function(a) {
  a.addEventListener('click', function(e) {
    e.preventDefault();
    var id = (a.getAttribute('href') || '').replace(/^#/, '');
    var wrap = document.getElementById(id);
    if (!wrap) return;
    // Scroll to slideshow wrapper
    wrap.scrollIntoView({ behavior: 'smooth', block: 'center' });
    history.replaceState(null, '', '#' + id);
    // If a slide number is given, tell the iframe to navigate there
    var slide = a.dataset.slide ? parseInt(a.dataset.slide, 10) : null;
    if (!slide) return;
    var iframe = wrap.querySelector('iframe');
    if (!iframe) return;
    var tryPost = function() {
      try {
        iframe.contentWindow.postMessage({ type: 'gotoSlide', slide: slide }, '*');
      } catch (_) {}
    };
    // Post immediately and again after load settles
    tryPost();
    setTimeout(tryPost, 600);
  });
});

// Listen for slideshowReady from iframes to apply aspect-ratio automatically
window.addEventListener('message', function(e) {
  if (!e.data || e.data.type !== 'slideshowReady') return;
  var vpW = e.data.viewportW, vpH = e.data.viewportH;
  if (!vpW || !vpH) return;
  // Find the iframe that sent this message
  document.querySelectorAll('[data-slideshow] iframe').forEach(function(iframe) {
    try {
      if (iframe.contentWindow === e.source) {
        iframe.style.aspectRatio = vpW + ' / ' + vpH;
      }
    } catch (_) {}
  });
});

/* ── Collapsible figures ────────────────────────────────────────── */
document.querySelectorAll('.manual-sheet figure').forEach(function(fig) {
  var parent = fig.parentElement;
  var img = fig.querySelector('img.collapsible');
  var isOsToggle = parent && parent.classList.contains('os-toggle-wrap') && parent.classList.contains('collapsible');
  if (!img && !isOsToggle && !(parent && parent.classList.contains('collapsible'))) return;

  var cap = fig.querySelector('figcaption');
  var capText = cap ? cap.textContent : 'Figure';

  var wrap = document.createElement('div');
  wrap.className = 'collapsible-fig';
  var body = document.createElement('div');
  body.className = 'collapsible-fig__body';
  var btn = document.createElement('button');
  btn.type = 'button';
  btn.className = 'collapsible-fig__toggle';
  btn.setAttribute('aria-expanded', 'false');
  btn.textContent = capText;

  var target = isOsToggle ? parent : fig;
  target.parentNode.insertBefore(wrap, target);
  body.appendChild(target);
  wrap.appendChild(body);
  wrap.appendChild(btn);

  btn.addEventListener('click', function() {
    var isOpen = wrap.classList.toggle('is-open');
    btn.setAttribute('aria-expanded', isOpen ? 'true' : 'false');
  });
});

/* ── OS variant image toggle ────────────────────────────────────── */
document.querySelectorAll('.os-toggle__btn').forEach(function(btn) {
  btn.addEventListener('click', function() {
    var figure = document.querySelector(btn.dataset.target);
    var img = figure ? figure.querySelector('img') : null;
    if (!img) return;

    img.src = btn.dataset.src;
    if (btn.dataset.alt) {
      img.alt = btn.dataset.alt;
      var cap = figure.querySelector('figcaption');
      if (cap) cap.textContent = cap.textContent.replace(/:.+$/, ': ' + btn.dataset.alt);
    }

    var group = btn.closest('.os-toggle');
    if (group) {
      group.querySelectorAll('.os-toggle__btn').forEach(function(b) {
        b.classList.remove('is-active');
      });
    }
    btn.classList.add('is-active');
  });
});

/* ── Collapsible headings ───────────────────────────────────────── */
document.querySelectorAll('.manual-sheet h1.collapsible, .manual-sheet h2.collapsible, .manual-sheet h3.collapsible, .manual-sheet h4.collapsible, .manual-sheet h5.collapsible, .manual-sheet h6.collapsible').forEach(function(heading) {
  var level = parseInt(heading.tagName[1]);
  var details = document.createElement('details');
  if (heading.classList.contains('collapsible-open')) details.open = true;
  var summary = document.createElement('summary');
  heading.classList.remove('collapsible', 'collapsible-open');
  heading.parentNode.insertBefore(details, heading);
  summary.appendChild(heading);
  details.appendChild(summary);
  var next = details.nextElementSibling;
  while (next) {
    var m = next.tagName.match(/^H(\d)$/i);
    if (m && parseInt(m[1]) <= level) break;
    var toMove = next;
    next = next.nextElementSibling;
    details.appendChild(toMove);
  }
});

/* ── Collapsible callouts ───────────────────────────────────────── */
document.querySelectorAll('.manual-sheet .callout-note.collapsible, .manual-sheet .callout-tip.collapsible, .manual-sheet .callout-warning.collapsible, .manual-sheet .callout-caution.collapsible').forEach(function(box) {
  var badge = box.querySelector('p:first-child > strong:first-child');
  if (!badge) return;

  box.classList.add('callout--collapsible');
  var isOpen = box.classList.contains('collapsible-open');
  if (isOpen) box.classList.add('callout--open');

  var toggle = document.createElement('div');
  toggle.className = 'callout__toggle';
  toggle.setAttribute('role', 'button');
  toggle.setAttribute('tabindex', '0');
  toggle.setAttribute('aria-expanded', isOpen ? 'true' : 'false');
  badge.parentNode.removeChild(badge);
  toggle.appendChild(badge);

  var body = document.createElement('div');
  body.className = 'callout__body';
  var inner = document.createElement('div');
  body.appendChild(inner);
  while (box.firstChild) { inner.appendChild(box.firstChild); }

  box.appendChild(toggle);
  box.appendChild(body);

  toggle.addEventListener('click', function() {
    var open = box.classList.toggle('callout--open');
    toggle.setAttribute('aria-expanded', open ? 'true' : 'false');
  });
  toggle.addEventListener('keydown', function(e) {
    if (e.key === 'Enter' || e.key === ' ') { e.preventDefault(); toggle.click(); }
  });
});
