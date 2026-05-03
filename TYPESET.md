# Custom Additions to the Cayman Theme

This document describes every custom component, include, and JavaScript feature layered on top of the [`jekyll-theme-cayman`](https://github.com/pages-themes/cayman) base theme.

---

## Project Structure

```
_includes/
  head-custom.html       # Injects assets/js/manual.js into <head>
  os-toggle.html         # OS-variant image toggle include
  icon-windows.html      # Inline Windows logo SVG

assets/
  css/style.scss         # All custom styles (compiled by Jekyll)
  js/manual.js           # All custom JavaScript

sections/                # One file per manual section (included by index.md)
  cover.html
  description.md
  toc.md
  materials.md
  get-to-know.md
  powering-up.md
  receiving-data.md
  configuring.md

index.md                 # Thin shell — frontmatter + {% include_relative %} calls
```

---

## Includes

### `_includes/os-toggle.html`

Renders a pair of buttons that swap between two OS-variant screenshots of the same step. Wraps to a single line so Kramdown does not break the block-HTML parser.

**Parameters:**

| Parameter | Required | Default | Description |
|---|---|---|---|
| `id` | ✓ | — | HTML `id` on the `<img>` (used by JS to target the image) |
| `src1` | ✓ | — | Path to the first image (relative to site root) |
| `alt1` | ✓ | — | Alt text / caption suffix for the first image |
| `src2` | ✓ | — | Path to the second image |
| `alt2` | ✓ | — | Alt text / caption suffix for the second image |
| `label1` | | `Windows 10` | Button label for the first variant |
| `label2` | | `Windows 11` | Button label for the second variant |
| `style` | | — | Inline CSS applied to the outer wrapper `<div>` (e.g. `width: 60%`) |
| `collapsible` | | — | Set to `true` to make the figure collapsible (adds `.collapsible` class) |

**Usage:**
```liquid
{% include os-toggle.html
   id="fig-extract"
   src1="assets/media/windows/step_win10.png" alt1="Step on Windows 10"
   src2="assets/media/windows/step_win11.png" alt2="Step on Windows 11"
   label1="Windows 10" label2="Windows 11"
   style="width: 80%"
   collapsible=true %}
```

---

### `_includes/icon-windows.html`

Inline SVG of the Windows logo, sized at `1em` and colored with `currentColor`. Suitable for inline use inside text or `<kbd>` elements.

**Usage:**
```liquid
Press the <kbd>Windows {% include icon-windows.html %}</kbd> key.
```

---

### `_includes/head-custom.html`

Injected into `<head>` automatically by the Cayman theme layout. Loads `assets/js/manual.js` with `defer`.

---

## JavaScript (`assets/js/manual.js`)

All scripts run after the DOM is parsed (`defer`). Sections, in order:

### 1 — Anchor Navigation

An IIFE that powers the fixed `<nav class="anchor-nav">` bar. Scans for all `h1–h4[id]` inside `.manual-sheet`, tracks scroll position, and updates the Prev/Next buttons with the adjacent heading label. Button labels animate with a height transition (skipped when `prefers-reduced-motion` is set).

**Required HTML** (already in `index.md`):
```html
<nav class="anchor-nav" aria-label="Section navigation">
  <button type="button" class="anchor-nav__btn anchor-nav__btn--prev" id="anchor-prev" …>
    <span class="anchor-nav__icon" aria-hidden="true">◀</span>
    <span class="anchor-nav__label">Previous section</span>
  </button>
  <button type="button" class="anchor-nav__btn anchor-nav__btn--next" id="anchor-next" …>
    <span class="anchor-nav__label">Next section</span>
    <span class="anchor-nav__icon" aria-hidden="true">▶</span>
  </button>
</nav>
```

### 2 — Figure & Table Auto-numbering

- Wraps every `img[alt]` inside `.manual-sheet` in a `<figure>` with a `<figcaption>` reading `Figure N: <alt text>`.
- Updates `<a class="figref" href="#fig-id">` links to `Figure N`.
- Finds `<p class="table-caption">` elements preceding tables and rewrites them as `Table N. <caption text>`.
- Updates `<a class="tblref" href="#tbl-id">` links to `Table N`.

**Usage:**
```markdown
![My screenshot](assets/media/screenshot.png){: #fig-screenshot style="width: 60%" }

See <a href="#fig-screenshot" class="figref"></a> for the screenshot.
```

### 3 — Collapsible Figures

Wraps any `<figure>` whose `<img>` carries `.collapsible`, or whose parent `div.os-toggle-wrap` carries `.collapsible`, in a `div.collapsible-fig` with a toggle `<button>`. The button caption is taken from the `<figcaption>` text.

Applied via Kramdown IAL:
```markdown
![My image](assets/media/image.png){: .collapsible style="width: 60%" }
```

### 4 — OS Variant Image Toggle

Wires up `click` handlers on every `.os-toggle__btn`. On click, swaps the `src` and `alt` of the targeted `<img>`, updates the `<figcaption>` if present, and marks the clicked button `.is-active`.

Driven entirely by `data-*` attributes rendered by `_includes/os-toggle.html`; no manual wiring needed.

### 5 — Collapsible Headings

Converts any `h1–h6.collapsible` inside `.manual-sheet` into a `<details>`/`<summary>` pair. All sibling elements up to the next heading of equal or higher level are moved inside the `<details>`. Add `.collapsible-open` to start expanded.

Applied via Kramdown IAL:
```markdown
### Windows PC
{: .collapsible .collapsible-open}
```

### 6 — Collapsible Callouts

Converts any `.callout-note/.callout-tip/.callout-warning/.callout-caution` that also carries `.collapsible` into an accordion. The leading `**Badge**` `<strong>` becomes a clickable `.callout__toggle`; remaining content collapses into `.callout__body`. Keyboard-accessible (`Enter`/`Space`).

Applied via Kramdown IAL:
```markdown
> **Tip**
> Content here.
{: .callout-tip .collapsible }
```

---

## CSS (`assets/css/style.scss`)

Imports the Cayman base theme, then adds custom sections (in file order):

| Section | Selectors |
|---|---|
| CSS custom properties | `:root` |
| Cover hero | `.cover-hero`, `.cover-hero__panel`, `.cover-hero__word`, etc. |
| Manual sheet | `.manual-sheet` |
| `<kbd>` styling | `kbd` |
| Non-TOC heading label | `.manual-sheet h4.no_toc` |
| UI element labels | `ui-tab`, `ui-menu`, `ui-btn` (custom HTML elements) |
| Callouts | `.callout-note`, `.callout-tip`, `.callout-warning`, `.callout-caution` |
| Collapsible callouts | `.callout--collapsible`, `.callout__toggle`, `.callout__body` |
| Image figures | `.manual-sheet figure`, `figcaption` |
| Collapsible headings | `.manual-sheet details`, `details > summary` |
| Collapsible figures | `.collapsible-fig`, `.collapsible-fig__body`, `.collapsible-fig__toggle` |
| OS variant toggle | `.os-toggle-wrap`, `.os-toggle`, `.os-toggle__btn` |
| Anchor navigation | `.anchor-nav`, `.anchor-nav__btn` |
| PCB interactive viewer | `.pcb-viewer-wrap`, `#pcb-viewer-frame` |

### Non-TOC Heading Label

A plain `h4` with the Kramdown `{: .no_toc}` IAL. The `.no_toc` class tells Kramdown to exclude the heading from the `{:toc}` list, and the same class is used in CSS to suppress the left-bar accent.

```markdown
#### My label
{: .no_toc}
```

### UI Element Labels

Three custom HTML elements styled as inline pill labels:

```html
Navigate to <ui-menu>Ports (COM & LPT)</ui-menu> in the device tree.
Click the <ui-tab>Details</ui-tab> tab.
Select <ui-btn>Bus reported device description</ui-btn>.
```

---

## Content Sections (`sections/`)

`index.md` uses `{% include_relative sections/<file> %}` to pull in each section. Add a new section by:

1. Creating `sections/my-section.md` (or `.html` for pure HTML).
2. Wrapping content in `<section class="manual-sheet" markdown="1"> … </section>`.
3. Adding `{% include_relative sections/my-section.md %}` at the appropriate position in `index.md`.

The `.md` extension works with `include_relative` and Kramdown processes the `markdown="1"` block normally.
