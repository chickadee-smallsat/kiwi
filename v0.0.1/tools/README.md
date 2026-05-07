# Tools

## Step Slideshow Annotator (`step-annotator.html`)

A browser-based authoring tool for creating annotated step-by-step image slideshows, exportable as self-contained HTML files for embedding in the manual.

### Opening the Tool

Open `step-annotator.html` directly in a browser (no server needed):

```
open tools/step-annotator.html
```

### Workflow

1. **Add steps** — Click **+ Add** in the left panel to create a step.
2. **Upload an image** — Drag-and-drop a screenshot onto the canvas area, or click **Browse…** / **🖼 Replace Image**.
3. **Set the step title and description** in the right panel.
4. **Annotate the image** using the toolbar:
   | Tool | Shortcut | How to use |
   |------|----------|------------|
   | Select / Move | `V` | Click to select an annotation; drag callouts or labels to reposition |
   | Numbered Callout | `C` | Click to place a numbered circle |
   | Arrow | `A` | Click and drag |
   | Highlight Box | `R` | Click and drag |
   | Text Label | `L` | Click to place |
5. **Write callout notes** — For each numbered callout, enter a description in the **Callout Notes** section of the right panel.
6. **Reorder / delete steps** using the ↑ ↓ ✕ controls on each step card.
7. **Save your project** with **💾 Save Project** (downloads a `.json` file you can reload later with **📂 Load Project**).
8. **Export** with **▶ Export Slideshow HTML** to download `slideshow.html`.

### Embedding in configuring.md

Place the exported `slideshow.html` in `assets/media/` (e.g., `assets/media/coolterm-slideshow.html`), then embed it in a Markdown section:

```html
<figure style="width: 100%; margin: 1.5rem auto">
  <iframe src="{{ '/assets/media/coolterm-slideshow.html' | relative_url }}"
          title="CoolTerm setup walkthrough"
          loading="lazy"
          scrolling="no"
          style="width: 100%; height: 600px; border: none; border-radius: 0.5rem"
          onload="(function(f){window.addEventListener('message',function(e){if(e.data&&e.data.type==='slideshow-resize')f.style.height=(e.data.height+4)+'px';});})(this);">
  </iframe>
  <figcaption>Step-by-step walkthrough of connecting to Kiwi via CoolTerm.</figcaption>
</figure>
```

The exported slideshow supports:
- **Keyboard navigation**: ← → arrow keys
- **Touch swipe** on mobile
- **Step dots** and Prev / Next buttons
- **Callout note list** shown below each image
- **Auto-height reporting** via `postMessage` for iframe sizing
