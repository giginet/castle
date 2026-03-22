---
name: deckset-markdown-authoring
description: Create, edit, and validate Deckset markdown presentations from raw notes. Use when a user asks for slide generation, Deckset markdown syntax, command usage, speaker notes conversion, media layout, transitions, or per-slide styling in Deckset-compatible markdown.
---

# Deckset Markdown Authoring

Use this skill to turn rough notes into production-ready Deckset markdown.

## Workflow: Notes to Slides

1. Extract structure from notes:
- Identify title slide content, core sections, and closing slide.
- Group bullets by one idea per slide.
- Mark optional presenter-only details as presenter notes.

2. Build a deck plan:
- 1 title slide.
- 1 agenda/overview slide if useful.
- Main content slides (one primary message each).
- 1 summary/CTA slide.

3. Generate markdown:
- Place global commands at the top, consecutive, no blank lines between them.
- Separate slides with `---`.
- Use per-slide commands (`[.command: value]`) only on the slide they affect.
- Keep slide text concise. Move detail into presenter notes (`^ ...`).

4. Validate:
- Confirm syntax and command scope.
- Confirm media modifiers are in image alt text.
- Confirm unique footnote IDs and valid fenced code blocks.

## Output Contract

- Default output is pure markdown only.
- Do not add explanatory prose unless requested.
- Preserve command spellings exactly.
- Prefer working examples over placeholders.

## Deckset Syntax and Commands

### Core Markdown

- Headings: `#`, `##`, `###`, `####`
- Fit headings: `# [fit] Heading text`
- Unordered lists: `- item`
- Ordered lists: `1. item`
- Nested lists: indent by 4 spaces
- Preserve explicit numbering on next ordered list: `[.use-source-list-numbering]`
- Emphasis: `*italic*`, `**bold**`, `_italic_`, `__bold__`, `~~strikethrough~~`
- Inline code: `` `code` ``
- Sup/Sub script: `<sup>text</sup>`, `<sub>text</sub>`
- Quotes:
  - `> Quote text`
  - `-- Author`
- Links:
  - External: `[Label](https://example.com)`
  - Internal anchors:
    - Target: `<a name="target-id"/>`
    - Link: `[Jump](#target-id)`
- Tables:
  - Header/body split with `---`
  - Alignment with `:---:`, `---:`
- Formulas:
  - Block: `$$ ... $$`
  - Inline: `Text $$x^2$$ text`
- Emojis: `:smile:`, `:thumbsup:`
- Footnotes:
  - Ref: `[^1]` or `[^Name]`
  - Definition: `[^1]: ...`
- Line breaks:
  - Literal line breaks in paragraphs are preserved
  - Use `<br>` where literal newlines are not supported
- Hide content/slide:
  - `<!-- ... -->`

### Code Blocks

- Fenced code:
  - ```` ```swift ... ``` ````
- Highlight lines with commands above the block:
  - `[.code-highlight: 2]`
  - `[.code-highlight: 2, 6-8]`
- Step through highlights by stacking commands:
  - `[.code-highlight: none]`
  - `[.code-highlight: 2]`
  - `[.code-highlight: 6-8]`
  - `[.code-highlight: all]`

### Columns

- Start each column with `[.column]`
- Add each additional column by repeating `[.column]`

### Presenter Notes

- Prefix paragraph with `^` for presenter notes
- Example:
  - `^ This is speaker-only context.`
- Global behavior:
  - `paragraphs-as-presenter-notes: true`
- Style command (global or per-slide):
  - `presenter-notes: #333333, alignment(left|right|center), line-height(9), text-scale(0.9), kern(0.5), capitalization(default|upper|title), Helvetica`
  - `[.presenter-notes: ...]`

### Global Commands (Top of File)

Use only at the top unless explicitly noted as also valid per slide.

- `autoscale: true`
- `build-lists: true`
- `build-lists: all`
- `build-lists: notFirst`
- `slidenumbers: true`
- `slidecount: true`
- `footer: Footer text`
- Block footer:
  - `footer: <<<`
  - `...markdown content...`
  - `>>>`
- `slide-transition: true`
- `slide-transition: fade(0.3)`
- `slide-transition: push(vertical)`
- `slide-dividers: #, ##, ###, ####` (global-only)
- `paragraphs-as-presenter-notes: true` (global-only)
- `time-budget: 20` (global-only)
- `code-language: Swift`
- `theme: Fira`
- `theme: Fira, 3` (global-only)
- `fit-header: #, ##` (global-only)
- `background-image: image.jpg`
- `image-corner-radius: 12`

### Per-Slide Commands

- `[.autoscale: true]`
- `[.autoscale: false]`
- `[.build-lists: true]`
- `[.build-lists: false]`
- `[.build-lists: notFirst]`
- `[.build-lists: not_first]`
- `[.slidenumbers: true]`
- `[.slidenumbers: false]`
- `[.slidecount: true]`
- `[.slidecount: false]`
- `[.footer: Alternative footer]`
- `[.hide-footer]`
- `[.slide-transition: push(horizontal, 0.3)]`
- `[.slide-transition: false]`

### Transitions

Available transition styles:
- `fade` (default crossfade)
- `fadeThroughColor(#000000)`
- `push(horizontal|vertical|top|right|bottom|left)`
- `move(horizontal|vertical|top|right|bottom|left)`
- `reveal(horizontal|vertical|top|right|bottom|left)`

Examples:
- Global:
  - `slide-transition: true`
  - `slide-transition: fade(0.3)`
  - `slide-transition: push(vertical)`
- Per-slide:
  - `[.slide-transition: push(horizontal, 0.3)]`
  - `[.slide-transition: false]`

### Images

Background-style:
- `![](image.jpg)` full background
- `![fit](image.jpg)` fit background
- Multiple background images by stacking `![](image.jpg)` lines
- `![original](image.jpg)` disable text-on-image filter
- `![original 250%](image.jpg)` zoom
- `![left](image.jpg)` split-left
- `![right](image.jpg)` split-right
- `![left filtered](image.jpg)` force filter
- `![right fit](image.jpg)` split + fit
- `![right alpha(0.6)](image.jpg)` opacity

Inline:
- `![inline](image.jpg)`
- `![inline fill](image.jpg)`
- `![inline 50%](image.jpg)`
- Grid by placing multiple inline images in sequence
- Rounded corners:
  - `![inline corner-radius(16)](image.jpg)`

### Video

- `![](video.mov)` background/full
- `![inline](video.mov)` inline
- YouTube URLs supported
- Layout modifiers: `left`, `right`, `fit`, `fill`, percentages, `hide`
- Playback modifiers: `autoplay`, `loop`, `mute`
- Auto advance:
  - `![autoadvance](video.mov)`
  - Constraint: must be last video on slide; slide cannot use build lists

### Audio

- `![](audio.mp3)`
- Layout modifiers: `left`, `right`, `fit`, `fill`, percentage, `hide`
- Playback modifiers: `autoplay`, `loop`, `mute`

### Mermaid and Pikchr

Mermaid:
- Use fenced language `mermaid`
- Graph colors per slide:
  - `[.graph: #ffffff, #aaffff, #000000, dark-mode(false)]`

Pikchr:
- Use fenced language `pikchr`
- Graph colors per slide:
  - `[.pikchr-graph: #f8f8f8, #003366]`

### Slide-Level Styling Commands

Text-like commands:
- `.text`, `.text-emphasis`, `.text-strong`
- `.header`, `.header-emphasis`, `.header-strong`
- `.slidenumber-style`, `.footer-style`

Examples:
- `[.text: #000000, alignment(left|center|right), line-height(10), text-scale(2.0), kern(1), Avenir Next Regular]`
- `[.header: #FF0000, alignment(left|center|right), line-height(18), text-scale(3.0), Avenir Next Bold, capitalization(default|upper|title)]`
- `[.footer-style: #2F2F2F, alignment(left|center|right), line-height(8), text-scale(1.5), Avenir Next Regular]`
- `[.background-color: #FF0000]`
- `[.list: #000000, bullet-character(Custom String), alignment(left|center|right), bullet-color(#ffcc00), text-scale(1.2), bullet-indent(40), ordered-bullet-indent(20)]`
- `[.table-separator: #000000, stroke-width(10)]`
- `[.table: margin(5)]`
- `[.code: auto(42), Font Family Name, line-height(4.2)]`
- `[.code: auto]`
- `[.code: #ffcc00, #1b1b1b, #ffffff]`
- `[.code: dimmed-opacity(0.2)]`
- `[.inline-code: text-scale(0.9), Font Family Name, auto(42)]`
- `[.footnote: #000000, alignment(left|center|right), line-height(10), text-scale(2.0), Avenir Next Regular]`
- `[.footnote-separator: #001100, height(10), margin(12)]`
- `[.formula: text-scale(42), alignment(center), #ff0011]`
- `[.link: #00aaff, Avenir Next Regular, line-height(10), text-scale(1.1), underline(single, byWord)]`
- `[.quote: #000000, alignment(left|center|right), line-height(10), text-scale(2.0), Avenir Next Regular]`
- `[.quote-author: #000000, alignment(left|center|right), line-height(10), text-scale(2.0), Avenir Next Regular]`
- `[.presenter-notes: #333333, alignment(left), line-height(9), text-scale(0.9), Avenir Next Regular]`
- `[.graph: #ffffff, #aaffff, #000000, dark-mode(false)]`
- `[.pikchr-graph: #f8f8f8, #003366]`

## Slide Construction Heuristics

- Keep 1 idea per slide.
- Keep headings short and concrete.
- If a slide exceeds readable length, use:
  - split into multiple slides, or
  - `autoscale: true` / `[.autoscale: true]`
- Use presenter notes for detail, not visible slide body.
- Use visuals only when they support the point.
- Prefer consistent transition/style usage across the deck.

## Final Validation Checklist

- Global commands are top-of-file and contiguous.
- Per-slide commands are local to target slide.
- No invalid command spellings.
- Fenced blocks are balanced and typed correctly.
- Media modifiers are in alt text.
- Footnote references are unique.
- Internal anchors resolve.
- Markdown contains only the requested output.

Version: 1.1.1
