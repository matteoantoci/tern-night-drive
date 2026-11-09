# Retro themes: what mature synthwave themes learned

Research date: 2026-11-09. Scope: synthwave, outrun, retrowave, cyberpunk and pastel retro themes for editors and terminals. The goal is to find what the "Sunset Grid" palette misses. This file is research, not design.

Method. I read the theme source files (VS Code theme JSON, Neovim Lua, Ghostty palette files, tmTheme), the READMEs and CHANGELOGs, the git history, and the GitHub issues. I computed all contrast ratios with the WCAG 2.2 formula ([relative luminance](https://www.w3.org/TR/WCAG22/#dfn-relative-luminance), [contrast ratio](https://www.w3.org/TR/WCAG22/#dfn-contrast-ratio)). For colors with an alpha channel, I first blended the color over its background. "Current palette" means `VARIANTS.A.tokens` in `prototype/index.html` as read on 2026-11-09. Variant D now overrides `--ansi8` to `#76649a`, so the tables show both values.

Themes checked (all exist): [SynthWave '84](https://github.com/robb0wen/synthwave-vscode), [Outrun (Night, Electric, unshipped Day)](https://github.com/samrap/outrun-theme-vscode), [LaserWave (normal, Italic, High Contrast)](https://github.com/Jaredk3nt/laserwave), [Cyberpunk (normal, Umbra, Scarlet)](https://github.com/prometheux-ar/cyberpunk) (formerly `max-SS/cyberpunk`), [Shades of Purple (normal, Super Dark)](https://github.com/ahmadawais/shades-of-purple-vscode), [Tokyo Night for VS Code](https://github.com/tokyo-night/tokyo-night-vscode-theme), [tokyonight.nvim](https://github.com/folke/tokyonight.nvim), [Horizon (dark and Bright)](https://github.com/jolaleye/horizon-theme-vscode), [Radical](https://github.com/dhedgecock/radical-vscode), [SynthWave x Fluoromachine](https://github.com/webrender/synthwave-x-fluoromachine), [Fairy Floss](https://github.com/sailorhg/fairyfloss), and the Ghostty palettes in [iTerm2-Color-Schemes](https://github.com/mbadolato/iTerm2-Color-Schemes/tree/master/ghostty). I found no separate "Cyberpunk 2077" VS Code theme repository. The Cyberpunk README links only a "CyberPunk2077-umbra" Windows Terminal port ([README](https://github.com/prometheux-ar/cyberpunk/blob/master/README.md)). A standalone "Cyberpunk 2077" editor theme is [unconfirmed].

Important: the current palette copies most of its syntax colors from SynthWave '84. `#fede5d`, `#36f9f6`, `#72f1b8`, `#fe4450`, `#ff7edb`, `#ff8b39` and `#f97e72` all come from the [SynthWave '84 theme file](https://github.com/robb0wen/synthwave-vscode/blob/master/themes/synthwave-color-theme.json). So the SynthWave '84 issue tracker applies almost directly to Sunset Grid.

---

## Top 5 findings

1. **Neon goes on meaning, not on everything.** Mature themes keep a quiet tier for structure and UI. Radical describes itself as "semi-monochromatic ... with pops of color for important things" ([THEME.md](https://github.com/dhedgecock/radical-vscode/blob/main/assets/THEME.md)). Tokyo Night makes "many UI elements ... intentionally low contrast so as not to distract" ([README](https://github.com/tokyo-night/tokyo-night-vscode-theme/blob/master/README.md)). The most used LaserWave token color is a dim punctuation color, `#7b6995` (3.20:1) ([theme file](https://github.com/Jaredk3nt/laserwave/blob/master/themes/LaserWave-color-theme.json)). The current palette has no dim syntax tier. Operators use `#ff7edb` at 7.96:1. Cyan `#36f9f6` carries five roles.
2. **Glow is opt-in, low-alpha and static.** The SynthWave '84 author writes that the glow "started as a joke and was never intended for long-term coding sessions" and warns about eye strain ([README](https://github.com/robb0wen/synthwave-vscode/blob/master/README.md)). He refused an animated glow because animation forces a layout and paint on every frame ([#161](https://github.com/robb0wen/synthwave-vscode/issues/161)). Without text glow, the theme puts only a faint inset glow (alpha `0x25`, about 15 %) and a 4 px gradient stripe on the one active tab ([editor_chrome.css](https://github.com/robb0wen/synthwave-vscode/blob/master/src/css/editor_chrome.css)). The current palette glows at full accent strength on three surfaces, and one of them (`.sf-tool.card`) repeats on every tool card.
3. **Comments and bright black are the top readability complaints.** The fixes target about 4.5:1 for comments and about 3:1 for ANSI 8. SynthWave '84 raised its comment color from 2.17:1 to 4.66:1 after [#124](https://github.com/robb0wen/synthwave-vscode/issues/124). tokyonight.nvim changed bright black after users could not read zsh autosuggestions ([#28](https://github.com/folke/tokyonight.nvim/issues/28)). The current `--tk-comment` passes 4.5:1 by 0.01 on `--tv-bg` (4.51) and fails it on `--card` (4.19). The variant A `--ansi8` fails 3:1 (2.95). The variant D value passes (3.49).
4. **Users read comments through the selection, and the selection breaks them.** SynthWave '84 users reported that a selected comment became "impossible to read" ([#124](https://github.com/robb0wen/synthwave-vscode/issues/124)). The fix commit raised the comment color and also lowered the selection alpha from `#ffffff36` to `#ffffff20` ([3b66c31](https://github.com/robb0wen/synthwave-vscode/commit/3b66c31)). Shades of Purple still has the same open bug for stacked highlights ([#149](https://github.com/ahmadawais/shades-of-purple-vscode/issues/149)). The current palette defines no selection color. Its pink tree-row tint (22 %) drops `--tk-comment` to 3.22:1.
5. **Neon on a light background does not work without a new palette.** SynthWave '84 has had open requests for a light version since 2019 ([#43](https://github.com/robb0wen/synthwave-vscode/issues/43), [#200](https://github.com/robb0wen/synthwave-vscode/issues/200)). Outrun has an `outrun-day` file that reuses the night token colors at 1.3:1 to 2.9:1, and the theme never registers it ([package.json](https://github.com/samrap/outrun-theme-vscode/blob/master/package.json)). The author wrote: "Turns out it's kinda difficult to put synthwave colors on a light background" ([#7](https://github.com/samrap/outrun-theme-vscode/issues/7)). The light themes that ship (Horizon Bright, Tokyo Night Light/Day) make a darker version of each accent.

---

## 1. Palette structure

### 1.1 Background: tinted, not black, mid-dark

No mature theme uses pure black for the editor. All use a dark blue-violet tint. Most keep the background saturation low.

| Theme | Editor background | HSL | Source |
|---|---|---|---|
| SynthWave '84 | `#262335` | H250 S20 L17 | [theme](https://github.com/robb0wen/synthwave-vscode/blob/master/themes/synthwave-color-theme.json) |
| LaserWave | `#27212e` | H268 S16 L15 | [theme](https://github.com/Jaredk3nt/laserwave/blob/master/themes/LaserWave-color-theme.json) |
| Horizon | `#1C1E26` | H228 S15 L13 | [theme](https://github.com/jolaleye/horizon-theme-vscode/blob/master/themes/horizon.json) |
| Tokyo Night | `#1a1b26` | H235 S19 L13 | [theme](https://github.com/tokyo-night/tokyo-night-vscode-theme/blob/master/themes/tokyo-night-color-theme.json) |
| Radical | `#141322` | H244 S28 L10 | [dist/Radical.json](https://github.com/dhedgecock/radical-vscode/blob/main/dist/Radical.json) |
| Shades of Purple | `#2D2B55` | H243 S33 L25 | [theme](https://github.com/ahmadawais/shades-of-purple-vscode/blob/master/themes/shades-of-purple-color-theme.json) |
| Shades of Purple Super Dark | `#191830` | H243 S33 L14 | [theme](https://github.com/ahmadawais/shades-of-purple-vscode/blob/master/themes/shades-of-purple-color-theme-super-dark.json) |
| Cyberpunk | `#261D45` | H253 S41 L19 | [theme](https://github.com/prometheux-ar/cyberpunk/blob/master/themes/cyberpunk-color-theme.json) |
| Cyberpunk Umbra | `#100d23` | H248 S46 L9 | [theme](https://github.com/prometheux-ar/cyberpunk/blob/master/themes/cyberpunk-umbra-color-theme.json) |
| Outrun Night | `#161130` | H250 S48 L13 | [theme](https://github.com/samrap/outrun-theme-vscode/blob/master/themes/outrun-night-color-theme.json) |
| Outrun Electric | `#0c0a20` | H245 S52 L8 | [theme](https://github.com/samrap/outrun-theme-vscode/blob/master/themes/outrun-electric-color-theme.json) |
| SynthWave x Fluoromachine | `#200933` | H273 S70 L12 | [theme](https://github.com/webrender/synthwave-x-fluoromachine/blob/master/themes/synthwave-x-fluoromachine.json) |
| Fairy Floss | `#5A5475` | H251 S16 L39 | [tmTheme](https://github.com/sailorhg/fairyfloss/blob/gh-pages/fairyfloss.tmTheme) |
| **Current `--tv-bg`** | `#1b1030` | H261 S50 L13 | prototype |
| **Current `--page`** | `#120a22` | H260 S55 L9 | prototype |

Observations:

- The UI chrome is darker than the editor. SynthWave '84 uses `#262335` for the editor, `#241b2f` for the sidebar and `#171520` for the activity bar. Tokyo Night uses `#1a1b26` for the editor and `#16161e` for the sidebar, the status bar and the panel. The current palette follows the same pattern (`--page` darker than `--tv-bg`).
- SynthWave '84 also paints a faint vertical gradient on the editor (`#2a2139` at 75 % to `#34294f`) in its optional chrome CSS ([editor_chrome.css](https://github.com/robb0wen/synthwave-vscode/blob/master/src/css/editor_chrome.css)).
- Users who want a darker background get a second variant or a settings snippet. Shades of Purple ships Super Dark. Cyberpunk ships Umbra. Outrun ships Electric as "the original, high-contrast" theme and Night as "a less-intense version" with a "more neutral, lighter background" ([CHANGELOG](https://github.com/samrap/outrun-theme-vscode/blob/master/CHANGELOG.md), [#7](https://github.com/samrap/outrun-theme-vscode/issues/7)). SynthWave '84 users ask for darker or black backgrounds ([#211](https://github.com/robb0wen/synthwave-vscode/issues/211), [#68](https://github.com/robb0wen/synthwave-vscode/issues/68)). The answers are user overrides, not theme changes.
- LaserWave changed its background once, from `#242029` to `#27212e` (v1.1.1, [CHANGELOG](https://github.com/Jaredk3nt/laserwave/blob/master/CHANGELOG.md)).
- The current `--tv-bg` has the high saturation (S50) of Outrun Night and Electric. The calmer themes (SynthWave '84, LaserWave, Horizon, Tokyo Night) stay at S15 to S20.

### 1.2 How many accents

I counted the distinct token foreground colors in each theme file and weighted them by the number of scopes that use them.

| Theme | Distinct token colors | Dominant colors (contrast on its own background) |
|---|---|---|
| SynthWave '84 | 12 | `#72f1b8` 10.9, `#fede5d` 11.5, `#ff7edb` 6.7, `#36f9f6` 11.7, `#fe4450` 4.5 |
| LaserWave | 11 | `#7b6995` 3.2 (punctuation, most used), `#40b4c4` 6.4, `#74dfc4` 9.7, `#ffe261` 12.1, `#eb64b9` 5.3 |
| Horizon | 7 | `#e95678` 4.8, `#b877db` 5.3, `#f09483` 7.3, `#fab795` 9.7, `#25b0bc` 6.3 |
| Shades of Purple | 20 | `#9effff` 11.5, `#fad000` 8.9, `#ff9d00` 6.3, `#a5ff90` 10.9 |
| Outrun Electric | 29 | `#1ea8fc` 7.5, `#ff2afc` 6.5, `#42c6ff` 10.0, `#ffd400` 13.6 |
| Cyberpunk | 28 | `#00b0ff` 6.4, `#00ff9c` 11.7, `#f07178` 5.5, `#eeffff` 15.2 |
| Tokyo Night | 34 | `#bb9af7` 7.4, `#89ddff` 11.3, `#7aa2f7` 6.8, `#e0af68` 8.5 |

Sources: the theme files in the table in 1.1.

The usual core is four or five saturated accents plus one or two neutral tones. The Cyberpunk author defends a wide palette on purpose: "it may look like a rainbow ... it allows me to use a very wide color palette" so that each code fragment gets its own color ([README](https://github.com/prometheux-ar/cyberpunk/blob/master/README.md)). He is the exception, and he says so.

### 1.3 How they keep neon colors from fighting

- **A dim structural tier.** LaserWave gives punctuation "Roman Silver" `#7b6995` and comments "Old Lavender" `#91889b`. Its README color table lists them next to the neon colors ([README](https://github.com/Jaredk3nt/laserwave/blob/master/README.md)). SynthWave '84 gives key-value separators `#b6b1b1` ([theme](https://github.com/robb0wen/synthwave-vscode/blob/master/themes/synthwave-color-theme.json)).
- **Low intensity by default.** Radical: "instead of having lots of bright colors, the theme is low intensity and has judicious use of bright colors" ([THEME.md](https://github.com/dhedgecock/radical-vscode/blob/main/assets/THEME.md)).
- **Quiet UI text.** SynthWave '84 draws UI text as white with alpha: `sideBar.foreground #ffffff99`, `statusBar.foreground #ffffff80`, line numbers `#ffffff73`. Tokyo Night uses `#787c99` for the sidebar, the status bar and inactive tabs ([themes](https://github.com/tokyo-night/tokyo-night-vscode-theme/blob/master/themes/tokyo-night-color-theme.json)). LaserWave puts dark text on its pink status bar "to decrease eye-strain" (v1.1.1, [CHANGELOG](https://github.com/Jaredk3nt/laserwave/blob/master/CHANGELOG.md)).
- **Glow as a hierarchy signal.** SynthWave '84 glows only five token colors (`fe4450`, `ff7edb`, `fede5d`, `72f1b8`, `36f9f6`). Strings, numbers and comments do not glow ([theme_template.js](https://github.com/robb0wen/synthwave-vscode/blob/master/src/js/theme_template.js)). A user noticed that when a language maps the wrong token to a glow color, the result "makes the code kind of confusing" ([#75](https://github.com/robb0wen/synthwave-vscode/issues/75)).
- **Separate meaning colors from syntax colors.** tokyonight.nvim keeps the syntax red `#f7768e`, the error red `red1 #db4b4b` and the git delete color `#914c54` apart. Diff backgrounds are blends at 25 % of `green2 #41a6b5` and `red1` ([storm.lua](https://github.com/folke/tokyonight.nvim/blob/main/lua/tokyonight/colors/storm.lua), [colors/init.lua](https://github.com/folke/tokyonight.nvim/blob/main/lua/tokyonight/colors/init.lua)).
- **A two-variant split instead of one compromise.** Outrun Night and Electric, LaserWave and LaserWave High Contrast, Shades of Purple and Super Dark, Cyberpunk and Umbra (sources in 1.1).

---

## 2. Glow and effects

### 2.1 What SynthWave '84 says about its glow

All quotes are from the [README](https://github.com/robb0wen/synthwave-vscode/blob/master/README.md) unless a link says otherwise.

- **Opt-in.** The base theme "is the way Synthwave '84 is intended to be used day-to-day". To get the glow, the user runs "Enable Neon Dreams". The extension then modifies the VS Code workbench HTML ([extension.js](https://github.com/robb0wen/synthwave-vscode/blob/master/src/extension.js)).
- **Not for long sessions.** "whilst it looks rad, it isn't intended for extended use". "The glow effect started as a joke and was never intended for long-term coding sessions."
- **Eye strain.** The brightness setting `synthwave84.brightness` defaults to `0.45`. "To avoid eye strain, avoid using higher brightness values for extended periods of time."
- **Glow and chrome are separate.** `synthwave84.disableGlow: true` keeps the "editor chrome updates" and removes the text glow.
- **Contrast work on the glow.** The author added opacity to the glow after "several issues raised on twitter about contrast" and "in the hopes of increasing usability" ([#15](https://github.com/robb0wen/synthwave-vscode/issues/15)).
- **How the glow is built.** Each glowing color becomes a near-white core with a colored halo and a 2 px dark outline. For example, yellow `#fede5d` becomes `color: #f4eee4; text-shadow: 0 0 2px #393a33, 0 0 8px #f39f05…, 0 0 2px #f39f05…`. Red becomes `#fff5f6` with a `0 0 2px #000` outline ([theme_template.js](https://github.com/robb0wen/synthwave-vscode/blob/master/src/js/theme_template.js)). The dark outline keeps the letter edges sharp.
- **Performance.** Users report high CPU load ([#210](https://github.com/robb0wen/synthwave-vscode/issues/210)) and cursor jumps and typing lag that stop when they disable Neon Dreams ([#362](https://github.com/robb0wen/synthwave-vscode/issues/362)). A glow mod also changed font antialiasing ([#269](https://github.com/robb0wen/synthwave-vscode/issues/269)).
- **Animation refused.** For a "breathing" glow request, the author wrote that animating `text-shadow` "triggers both a layout and paint cycle", and that "the number of elements in the editor that would need to be constantly repainted would cause a performance bottleneck". A user who built it reported that "my MacBook Air runs very hot" ([#161](https://github.com/robb0wen/synthwave-vscode/issues/161)).
- **Fragile.** The glow breaks after VS Code updates ([#354](https://github.com/robb0wen/synthwave-vscode/issues/354), [#333](https://github.com/robb0wen/synthwave-vscode/issues/333)). The README says to re-enable it after every VS Code update.

SynthWave x Fluoromachine stopped supporting its glow CSS: "I am no longer providing support for the custom CSS due to the performance impact on the application" ([README](https://github.com/webrender/synthwave-x-fluoromachine/blob/master/README.md)).

### 2.2 What the themes do instead of text glow

- **SynthWave '84 chrome without glow** ([editor_chrome.css](https://github.com/robb0wen/synthwave-vscode/blob/master/src/css/editor_chrome.css)):
  - Active tab: `box-shadow: inset 0 -5px 25px #fc28a825` (pink at about 15 % alpha) and a 4 px bottom stripe `linear-gradient(to right, #fc28a8, #03edf9)`.
  - Active activity-bar item: the same inset glow and a 4 px vertical stripe from pink to cyan.
  - Badges: `linear-gradient(to bottom, #fff951 25%, #fc28a8)`.
  - Lightbulb icon: `filter: drop-shadow(0 0 5px #03edf9)`.
  - Only one element per group glows: the active one.
- Users asked for a stronger active-tab signal, because the 1 px border and a slightly lighter label were "too subtle" ([#52](https://github.com/robb0wen/synthwave-vscode/issues/52)). The answers were a different inactive tab background and a thicker stripe, not more glow.
- **All other themes checked use color only.** LaserWave, Outrun, Horizon, Tokyo Night, Radical, Shades of Purple and Cyberpunk ship no glow code (repository trees: [LaserWave](https://github.com/Jaredk3nt/laserwave), [Outrun](https://github.com/samrap/outrun-theme-vscode), [Horizon](https://github.com/jolaleye/horizon-theme-vscode), [Radical](https://github.com/dhedgecock/radical-vscode)). They use a saturated status bar (LaserWave pink `#EB64B9` with dark text), colored focus borders (LaserWave `focusBorder #EB64B9`) or a darker chrome (Tokyo Night).

---

## 3. Readability problems that users report, and the fixes

### 3.1 Low-contrast comments

| Theme | Report | Before | After | Source |
|---|---|---|---|---|
| SynthWave '84 | "comments are nearly invisible". A user measured 2.17:1 and cited WCAG 4.5:1. | `#495495` (2.17) | `#949CD3` (5.79), then `#848bbd` (4.66) | [#124](https://github.com/robb0wen/synthwave-vscode/issues/124), [3b66c31](https://github.com/robb0wen/synthwave-vscode/commit/3b66c31), [970e145](https://github.com/robb0wen/synthwave-vscode/commit/970e145) |
| LaserWave | "very difficult to read with screen brightness lower than max" | `#48424e` (1.61) | `#a494b5` (5.57) on 2018-10-17, then `#91889b` (4.61) on 2018-10-18 ("changed color to be less pink") | [#12](https://github.com/Jaredk3nt/laserwave/issues/12), commits [4bbacd2](https://github.com/Jaredk3nt/laserwave/commit/4bbacd2) and [20b8ce3](https://github.com/Jaredk3nt/laserwave/commit/20b8ce3) |
| LaserWave | punctuation "does not provide enough contrast" | not known | "Small adjustment" in v1.3.0 [changed value unconfirmed; the current file uses `#7b6995` (3.20)], plus a new High Contrast variant (punctuation `#b4a8c8` 7.0, comment `#B4ABBE` 7.08) | [#37](https://github.com/Jaredk3nt/laserwave/issues/37), [HC theme](https://github.com/Jaredk3nt/laserwave/blob/master/themes/LaserWave-high-contrast-color-theme.json) |
| Tokyo Night | "Comments are too much dark" | | Author kept them at first ("I didn't seek to make a popular theme"), then "Brighten comment colors in dark themes" in v1.0.6. Current comment `#51597d` (2.50). | [#33](https://github.com/tokyo-night/tokyo-night-vscode-theme/issues/33), [CHANGELOG](https://github.com/tokyo-night/tokyo-night-vscode-theme/blob/master/CHANGELOG.md) |
| tokyonight.nvim | "Would love for the comments to be a bit more visible" | `comment #565f89` (2.76 on night) | Not changed. The author points to user overrides. | [#435](https://github.com/folke/tokyonight.nvim/issues/435), [storm.lua](https://github.com/folke/tokyonight.nvim/blob/main/lua/tokyonight/colors/storm.lua) |

Notes:

- In #12 the LaserWave author rejected a pinker comment color: "comments should be very unassuming and non-distracting so taking out some hue would fit the original goal" ([#12](https://github.com/Jaredk3nt/laserwave/issues/12)). His fix lowers the saturation (`#91889b` is S9), not only the lightness.
- Two themes use a saturated accent for comments instead of a gray. Shades of Purple uses `#B362FF` (3.85 on `#2D2B55`). Fairy Floss uses gold `#E6C000` (4.02 on `#5A5475`) ([SoP theme](https://github.com/ahmadawais/shades-of-purple-vscode/blob/master/themes/shades-of-purple-color-theme.json), [Fairy Floss tmTheme](https://github.com/sailorhg/fairyfloss/blob/gh-pages/fairyfloss.tmTheme)).
- Fluoromachine still uses the old SynthWave comment `#495495` (2.60 on `#200933`) ([theme](https://github.com/webrender/synthwave-x-fluoromachine/blob/master/themes/synthwave-x-fluoromachine.json)).
- The LaserWave README calls the High Contrast variant "WCAG AAA". On the shipped background `#27212e`, Hot Pink `#ff52bf` is 5.4:1 and violet `#d887f5` is 6.5:1. Both are below the AAA level of 7:1 ([SC 1.4.6](https://www.w3.org/TR/WCAG22/#contrast-enhanced)). The README also gives the HC background as `#19151e`, but the file uses `#27212e` ([#48](https://github.com/Jaredk3nt/laserwave/issues/48)).

### 3.2 Unreadable selection

- SynthWave '84: "selection color is hard to see" ([#1](https://github.com/robb0wen/synthwave-vscode/issues/1), [#2](https://github.com/robb0wen/synthwave-vscode/issues/2)). The early default was `#231a33`. A user proposed `#463465`. Later a comment under selection became "impossible to read" ([#124](https://github.com/robb0wen/synthwave-vscode/issues/124)). The fix commit changed the selection from `#ffffff36` to `#ffffff20` and the comment from `#495495` to `#949CD3` in one step ([3b66c31](https://github.com/robb0wen/synthwave-vscode/commit/3b66c31)). With the current values, the comment on the selection is 3.13:1 (blend `#413f4e`).
- SynthWave '84: overview-ruler selection marks are "almost invisible" ([#167](https://github.com/robb0wen/synthwave-vscode/issues/167), open).
- Tokyo Night: "the selection color is too light to recognize". The author gave a settings snippet ([#25](https://github.com/tokyo-night/tokyo-night-vscode-theme/issues/25)).
- Cyberpunk Scarlet: "The selected text cannot be highlighted" ([#115](https://github.com/prometheux-ar/cyberpunk/issues/115), open).
- Shades of Purple: comments become "indistinguishable" when find and selection highlights stack ([#149](https://github.com/ahmadawais/shades-of-purple-vscode/issues/149), open).
- Radical documents its rule: the selection uses "a lighter purple to allow for better contrast of selected text while not being overwhelming for multiline selections". The find highlight is "most bold" ([NOTES.md](https://github.com/dhedgecock/radical-vscode/blob/main/assets/NOTES.md)).

### 3.3 Bright, saturated text and eye strain

- SynthWave '84 glow brightness warning (section 2.1).
- Outrun split into Night ("less intense") and Electric ("high-contrast") "based on reviews on the marketplace" ([#7](https://github.com/samrap/outrun-theme-vscode/issues/7)).
- A SynthWave '84 user found the orange strings "kind of blah" next to the brighter colors ([#75](https://github.com/robb0wen/synthwave-vscode/issues/75)). This shows the opposite risk: when most colors are very bright, a medium color looks dull.
- Tokyo Night chose low-contrast UI on purpose and offers "Higher Contrast Settings" in the README ([README](https://github.com/tokyo-night/tokyo-night-vscode-theme/blob/master/README.md), [#55](https://github.com/tokyo-night/tokyo-night-vscode-theme/issues/55)).

### 3.4 Diffs

- SynthWave '84 has no diff-file syntax colors. The issue is open since 2023 ([#300](https://github.com/robb0wen/synthwave-vscode/issues/300), older [#106](https://github.com/robb0wen/synthwave-vscode/issues/106)). Its diff editor backgrounds are `#0beb9935` and `#fe445035` (about 21 % alpha).
- LaserWave changed the diff color "to improve legibility" (v1.2.6) and added diff file and gutter colors (v1.3.3) ([CHANGELOG](https://github.com/Jaredk3nt/laserwave/blob/master/CHANGELOG.md)). Its removed-line tint uses its brand pink, not a red: `#eb64b940`. Added is `#74dfc423`.
- Tokyo Night updated its diff colors in v1.0.7 ([CHANGELOG](https://github.com/tokyo-night/tokyo-night-vscode-theme/blob/master/CHANGELOG.md)). Tints are `#41a6b520` and `#db4b4b22` (about 13 %). The added color is teal, not green.
- Horizon tints at `1A` (about 10 %): `#09F7A01A`, `#F43E5C1A` ([theme](https://github.com/jolaleye/horizon-theme-vscode/blob/master/themes/horizon.json)).
- Pattern: diffs use a low-alpha background tint. The tint hue is often not the error red.

### 3.5 ANSI colors that break CLI tools

- **Bright black equal to black.** tokyonight.nvim set ANSI 8 to the same `#15161E` as ANSI 0. zsh autosuggestions became unreadable. Fix: a lighter `terminal_black` ([#25](https://github.com/folke/tokyonight.nvim/issues/25), [#28](https://github.com/folke/tokyonight.nvim/issues/28)). zsh-autosuggestions draws its suggestions in `fg=8` by default ([README](https://github.com/zsh-users/zsh-autosuggestions/blob/master/README.md)). So ANSI 8 is the color of suggested commands.
- **Bright black too dark.** Shades of Purple: Gulp timestamps in ANSI 8 were hard to read. The author changed `terminal.ansiBrightBlack` to `#5C5C61` in v1.16.0 ([#6](https://github.com/ahmadawais/shades-of-purple-vscode/issues/6)). The result is still only 2.41:1 on the terminal background `#1E1E3F`.
- **Bright colors equal to normal colors.** tokyonight.nvim terminal ports had `color9`–`color14` equal to `color1`–`color6` ([#540](https://github.com/folke/tokyonight.nvim/issues/540)). The current code computes each bright color with `Util.brighten` (+5 HSLuv lightness, +20 saturation) ([colors/init.lua](https://github.com/folke/tokyonight.nvim/blob/main/lua/tokyonight/colors/init.lua), [util.lua](https://github.com/folke/tokyonight.nvim/blob/main/lua/tokyonight/util.lua)).
- **Two slots with one color.** SynthWave '84 sets Blue, Cyan, BrightBlue and BrightCyan all to `#03edf9` ([theme](https://github.com/robb0wen/synthwave-vscode/blob/master/themes/synthwave-color-theme.json)). Fluoromachine sets Blue and Cyan to pink `#fc199a` and Red and Magenta to purple `#9165f6`, so error text in ANSI red shows as purple ([theme](https://github.com/webrender/synthwave-x-fluoromachine/blob/master/themes/synthwave-x-fluoromachine.json)). Tokyo Night had two different greens by mistake and fixed it ([#99](https://github.com/tokyo-night/tokyo-night-vscode-theme/issues/99)).
- **Missing slots.** SynthWave '84 does not define `ansiBlack`, `ansiWhite`, `ansiBrightBlack` or `ansiBrightWhite`. LaserWave defines only six ANSI colors ([theme](https://github.com/Jaredk3nt/laserwave/blob/master/themes/LaserWave-color-theme.json)). The terminal then uses its default values for the missing slots [unconfirmed which values VS Code uses].
- **No standard for 0, 7, 8, 15.** A contributor audited all iTerm2-Color-Schemes palettes and found ANSI 15 equal to the background in some light themes ("basically unusable"). The maintainer answered: "There is no standard that I'm aware of" ([#578](https://github.com/mbadolato/iTerm2-Color-Schemes/issues/578)). The same tracker has a report of "barely visible" completion text in a low-contrast palette ([#606](https://github.com/mbadolato/iTerm2-Color-Schemes/issues/606)).

---

## 4. ANSI table: how terminal palettes fill colors 0, 7, 8 and 15

Values from the Ghostty palette files in [iTerm2-Color-Schemes/ghostty](https://github.com/mbadolato/iTerm2-Color-Schemes/tree/master/ghostty) (one file per theme name). Ratios are against the palette's own background.

| Palette | Background | 0 | 7 | 8 | 15 |
|---|---|---|---|---|---|
| [Synthwave](https://github.com/mbadolato/iTerm2-Color-Schemes/blob/master/ghostty/Synthwave) | `#000000` | `#000000` 1.00 | `#ffffff` 21.0 | `#7f7094` 4.65 | `#ffffff` 21.0 |
| [Synthwave Alpha](https://github.com/mbadolato/iTerm2-Color-Schemes/blob/master/ghostty/Synthwave%20Alpha) | `#241b30` | `#241b30` 1.00 | `#b9b1bc` 7.91 | `#7f7094` 3.65 | `#f2f2e3` 14.58 |
| [Synthwave Everything](https://github.com/mbadolato/iTerm2-Color-Schemes/blob/master/ghostty/Synthwave%20Everything) | `#2a2139` | `#fefefe` 15.14 | `#fefefe` | `#fefefe` | `#fefefe` |
| [Outrun Electric](https://github.com/mbadolato/iTerm2-Color-Schemes/blob/master/ghostty/Outrun%20Electric) | `#0c0a20` | `#131033` 1.06 | `#f2f3f7` 17.54 | `#546a90` 3.56 | `#ffffff` 19.45 |
| [Cyberpunk](https://github.com/mbadolato/iTerm2-Color-Schemes/blob/master/ghostty/Cyberpunk) | `#332a57` | `#000000` 1.61 | `#ffffff` 13.05 | `#595959` 1.86 | `#ffffff` 13.05 |
| [Cyberpunk Scarlet Protocol](https://github.com/mbadolato/iTerm2-Color-Schemes/blob/master/ghostty/Cyberpunk%20Scarlet%20Protocol) | `#101116` | `#101116` 1.00 | `#c7c7c7` 11.15 | `#686868` 3.38 | `#ffffff` 18.85 |
| [Laser](https://github.com/mbadolato/iTerm2-Color-Schemes/blob/master/ghostty/Laser) | `#030d18` | `#626262` 3.20 | `#f1f1f1` 17.30 | `#8f8f8f` 6.04 | `#ffffff` 19.54 |
| [Miami Heat](https://github.com/mbadolato/iTerm2-Color-Schemes/blob/master/ghostty/Miami%20Heat) | `#120b2e` | `#2a1a4a` 1.21 | `#e6d4ff` 13.68 | `#5e5388` 2.76 | `#fce7ff` 16.18 |
| [Vaporwave Sunset](https://github.com/mbadolato/iTerm2-Color-Schemes/blob/master/ghostty/Vaporwave%20Sunset) | `#180827` | `#4b3d53` 1.90 | `#f0abfc` 10.82 | `#563f6e` 2.11 | `#fff7ed` 17.93 |
| [RadicalReborn](https://github.com/mbadolato/iTerm2-Color-Schemes/blob/master/ghostty/RadicalReborn) | `#141322` | `#30317d` 1.62 | `#cff0e8` 15.08 | `#4627c2` 2.03 | `#cbfff2` 16.69 |
| [Shades Of Purple](https://github.com/mbadolato/iTerm2-Color-Schemes/blob/master/ghostty/Shades%20Of%20Purple) | `#1e1d40` | `#000000` 1.30 | `#c7c7c7` 9.52 | `#686868` 2.89 | `#ffffff` 16.09 |
| [Horizon](https://github.com/mbadolato/iTerm2-Color-Schemes/blob/master/ghostty/Horizon) | `#1c1e26` | `#000000` 1.26 | `#e5e5e5` 13.20 | `#666666` 2.90 | `#e5e5e5` 13.20 |
| [Fairyfloss](https://github.com/mbadolato/iTerm2-Color-Schemes/blob/master/ghostty/Fairyfloss) | `#5a5475` | `#040303` 2.90 | `#f8f8f0` 6.65 | `#6090cb` 2.15 | `#f8f8f0` 6.65 |
| [TokyoNight Night](https://github.com/mbadolato/iTerm2-Color-Schemes/blob/master/ghostty/TokyoNight%20Night) | `#1a1b26` | `#15161e` 1.05 | `#a9b1d6` 8.10 | `#414868` 1.91 | `#c0caf5` 10.59 |
| [Dracula](https://github.com/mbadolato/iTerm2-Color-Schemes/blob/master/ghostty/Dracula) (reference) | `#282a36` | `#21222c` 1.11 | `#f8f8f2` 13.36 | `#6272a4` 3.03 | `#ffffff` 14.24 |
| **Current, variant A** | `#1b1030` | `#2a1b3d` 1.14 | `#e0d5f0` 12.85 | `#6b5a86` 2.95 | `#ffffff` 18.05 |
| **Current, variant D** | `#1b1030` | same | same | `#76649a` 3.49 | same |

Editor-theme terminal palettes (VS Code JSON):

| Theme | Terminal bg | 0 | 7 | 8 | 15 | Source |
|---|---|---|---|---|---|---|
| Outrun Electric | `#090819` | `#283034` 1.47 | `#d9e0e9` | `#435056` 2.38 | `#f4f6f9` | [theme](https://github.com/samrap/outrun-theme-vscode/blob/master/themes/outrun-electric-color-theme.json) |
| Shades of Purple | `#1E1E3F` | `#000000` 1.31 | `#FFFFFF` | `#5C5C61` 2.41 | `#FFFFFF` | [theme](https://github.com/ahmadawais/shades-of-purple-vscode/blob/master/themes/shades-of-purple-color-theme.json) |
| Radical | `#141322` | `#30317D` 1.62 | `#cff0e8` | `#391AB5` 1.74 | `#cbfff2` | [dist/Radical.json](https://github.com/dhedgecock/radical-vscode/blob/main/dist/Radical.json) |
| Tokyo Night | `#16161e` | `#363b54` | `#787c99` 4.40 | `#363b54` 1.64 | `#acb0d0` | [theme](https://github.com/tokyo-night/tokyo-night-vscode-theme/blob/master/themes/tokyo-night-color-theme.json) |
| SynthWave '84 | not set | not set | not set | not set | not set | [theme](https://github.com/robb0wen/synthwave-vscode/blob/master/themes/synthwave-color-theme.json) |

Patterns:

- **Color 0** is usually the background or a shade within 1.0 to 1.3:1 of it. tokyonight.nvim computes it as the background blended 80 % toward black (`Util.blend_bg(colors.bg, 0.8, "#000000")`, [colors/init.lua](https://github.com/folke/tokyonight.nvim/blob/main/lua/tokyonight/colors/init.lua)). Some ports keep pure `#000000` on a purple background (Cyberpunk, Shades of Purple, Horizon).
- **Color 7** is a dimmed foreground. tokyonight.nvim maps it to `fg_dark #a9b1d6`, and color 15 to `fg #c0caf5`.
- **Color 8** is the weak point. Only Synthwave, Synthwave Alpha, Outrun Electric, Cyberpunk Scarlet Protocol, Laser and Dracula reach 3:1. tokyonight.nvim maps it to `terminal_black #414868`, a separate token from the comment color.
- **Color 15** is white or the full foreground.
- **Synthwave Everything** sets 0, 7, 8 and 15 all to `#fefefe`. Text that a tool prints in "black" becomes white. This file shows what goes wrong when a port fills the 16 slots from an editor theme that does not define them.

---

## 5. Typography and style

| Theme | Italic | Bold | Font named by the author | Source |
|---|---|---|---|---|
| SynthWave '84 | comments, parameters, HTML attributes, Markdown quotes | Markdown headings, language variables (`this`) | Fira Code ("if you're a fan of ligatures") | [README](https://github.com/robb0wen/synthwave-vscode/blob/master/README.md), [theme](https://github.com/robb0wen/synthwave-vscode/blob/master/themes/synthwave-color-theme.json) |
| Tokyo Night | comments, flow keywords, `storage.modifier` and more | | JetBrains Mono (screenshots) | [README](https://github.com/tokyo-night/tokyo-night-vscode-theme/blob/master/README.md) |
| tokyonight.nvim | `comments = { italic = true }`, `keywords = { italic = true }` (configurable) | `lualine_bold` option | | [README](https://github.com/folke/tokyonight.nvim/blob/main/README.md) |
| Shades of Purple | "very limited" italics, a separate Italic variant | | Operator Mono, font size 17, line height 24.65, letter spacing 0.5 | [readme](https://github.com/ahmadawais/shades-of-purple-vscode/blob/master/readme.md), [#13](https://github.com/ahmadawais/shades-of-purple-vscode/issues/13) |
| LaserWave | none in the base theme; a separate "LaserWave Italic" variant for keywords and attributes (v1.2.0) | | | [README](https://github.com/Jaredk3nt/laserwave/blob/master/README.md), [CHANGELOG](https://github.com/Jaredk3nt/laserwave/blob/master/CHANGELOG.md) |
| Horizon | "only uses italics in a few places"; separate Italic and Bold variants | Horizon Bold variant | | [README](https://github.com/jolaleye/horizon-theme-vscode/blob/master/README.md), [CHANGELOG](https://github.com/jolaleye/horizon-theme-vscode/blob/master/CHANGELOG.md) |
| Outrun | italic comments; italic cyan `this`/`super` | | | [CHANGELOG](https://github.com/samrap/outrun-theme-vscode/blob/master/CHANGELOG.md) |
| Cyberpunk | italic comments | | | [theme](https://github.com/prometheux-ar/cyberpunk/blob/master/themes/cyberpunk-color-theme.json) |
| Fluoromachine | italic comments | | Rec Mono Casual | [README](https://github.com/webrender/synthwave-x-fluoromachine/blob/master/README.md) |

Observations:

- Every theme with italics gets requests to remove them: SynthWave '84 ([#216](https://github.com/robb0wen/synthwave-vscode/issues/216)), Tokyo Night ([#68](https://github.com/tokyo-night/tokyo-night-vscode-theme/issues/68)), Shades of Purple ([#13](https://github.com/ahmadawais/shades-of-purple-vscode/issues/13)). The Tokyo Night author: "italics are either loved, tolerated, or hated". Each author answers with a non-italic path: a README snippet (Tokyo Night, Horizon), an FAQ link (Shades of Purple), or a separate variant (LaserWave, Horizon).
- Italic comments plus a script-style italic font (Operator Mono) is the classic retro look. Its value depends on the font. A plain monospace font with a synthetic slant reads worse [unconfirmed: no source measures this].
- Bold is rare in syntax. Themes use it for headings and for one or two special tokens.

---

## 6. Light variants

| Theme | Light variant | How it translates the palette | Source |
|---|---|---|---|
| SynthWave '84 | none | Requests open since 2019. Author: "I have some ideas ... when I get the time". | [#43](https://github.com/robb0wen/synthwave-vscode/issues/43), [#200](https://github.com/robb0wen/synthwave-vscode/issues/200) |
| Outrun | `outrun-day-color-theme.json` exists but is not in `contributes.themes` | Background `#f5f5fb`, foreground `#161130`. Token colors are the same as Night: `#ff2afc` 2.8:1, `#1ea8fc` 2.4:1, `#42c6ff` 1.8:1, `#ffd400` 1.3:1. The terminal block still uses the night background `#090819`. | [file](https://github.com/samrap/outrun-theme-vscode/blob/master/themes/outrun-day-color-theme.json), [package.json](https://github.com/samrap/outrun-theme-vscode/blob/master/package.json), [#7](https://github.com/samrap/outrun-theme-vscode/issues/7) |
| Horizon | Horizon Bright (v2.0.0) | Warm off-white background `#FDF0ED`. Each accent is darker and more saturated: keyword `#B877DB` to `#8A31B9` (5.86), function `#25B0BC` to `#1D8991` (3.74), red `#E95678` to `#DA103F` (4.57). The orange string `#F6661E` is still 2.76. Comments are `#33333380` (2.78). The VS Code terminal block keeps the dark-theme ANSI values (yellow `#FAB795` is 1.54 on the light background). | [horizon-bright.json](https://github.com/jolaleye/horizon-theme-vscode/blob/master/themes/horizon-bright.json), [CHANGELOG](https://github.com/jolaleye/horizon-theme-vscode/blob/master/CHANGELOG.md) |
| Tokyo Night (VS Code) | Tokyo Night Light | A separate, darker palette: keyword `#65359d` (6.7), function `#2959aa` (5.5), on `#e6e7ed`. A user said the first light theme was "too low contrast". The author changed it, and later "Redesign[ed] Tokyo Night Light theme to improve contrast" (v1.0.9). ANSI 0 is dark ink `#343B58`. ANSI 7 and 15 are the same gray `#707280`. | [light theme](https://github.com/tokyo-night/tokyo-night-vscode-theme/blob/master/themes/tokyo-night-light-color-theme.json), [#88](https://github.com/tokyo-night/tokyo-night-vscode-theme/issues/88), [CHANGELOG](https://github.com/tokyo-night/tokyo-night-vscode-theme/blob/master/CHANGELOG.md) |
| tokyonight.nvim | Day | Generated. Every color is converted to HSLuv and its lightness is inverted (`100 - L`). Colors that end below L 40 get lifted by `day_brightness` (default 0.3). | [day.lua](https://github.com/folke/tokyonight.nvim/blob/main/lua/tokyonight/colors/day.lua), [util.lua](https://github.com/folke/tokyonight.nvim/blob/main/lua/tokyonight/util.lua), [README](https://github.com/folke/tokyonight.nvim/blob/main/README.md) |
| LaserWave, Shades of Purple, Cyberpunk, Radical, Fluoromachine, Fairy Floss | none | | repository theme folders (links in the intro) |

ANSI semantics on light backgrounds differ between ports. The Ghostty "TokyoNight Day" file inverts the slots: ANSI 0 `#e9e9ed` is near the background and ANSI 15 `#3760bf` is dark. The Ghostty "Horizon Bright" file keeps the names: ANSI 0 `#16161d` is dark and ANSI 15 `#fff2ef` is near the background (1.02:1) ([TokyoNight Day](https://github.com/mbadolato/iTerm2-Color-Schemes/blob/master/ghostty/TokyoNight%20Day), [Horizon Bright](https://github.com/mbadolato/iTerm2-Color-Schemes/blob/master/ghostty/Horizon%20Bright)). The iTerm2-Color-Schemes maintainer confirms that no standard exists ([#578](https://github.com/mbadolato/iTerm2-Color-Schemes/issues/578)).

---

## 7. What is missing in the current palette

Thresholds, from WCAG 2.2:

- Text: 4.5:1 minimum, 3:1 for large text (18 pt, or 14 pt bold) ([SC 1.4.3](https://www.w3.org/TR/WCAG22/#contrast-minimum), [large scale](https://www.w3.org/TR/WCAG22/#dfn-large-scale)). Text in an inactive UI component has no requirement.
- UI components and states, and graphical objects: 3:1 against adjacent colors ([SC 1.4.11](https://www.w3.org/TR/WCAG22/#non-text-contrast)).
- Enhanced text: 7:1 ([SC 1.4.6](https://www.w3.org/TR/WCAG22/#contrast-enhanced)).

### 7.1 Contrast of the current palette on its three main surfaces

| Token | Value | on `--tv-bg` `#1b1030` | on `--page` `#120a22` | on `--card` `#231540` | Result on `--tv-bg` |
|---|---|---|---|---|---|
| `--tv-fg`, `--t1`, `--ink` | `#f2e6ff` | 15.07 | 16.06 | 14.00 | pass 4.5 (and 7) |
| `--t2` | `#c9b3e6` | 9.52 | 10.14 | 8.84 | pass 4.5 |
| `--t3` | `#9a84bd` | 5.51 | 5.87 | 5.12 | pass 4.5 |
| `--t4` | `#5e4b80` | 2.40 | 2.56 | 2.23 | **fail 3** |
| `--tk-comment` | `#8a75b0` | 4.51 | 4.81 | 4.19 | pass 4.5 by 0.01; **fails 4.5 on `--card`** |
| `--tk-keyword`, `--warn`, `--omp-mdCode`, `--ansi3` | `#fede5d` | 13.60 | 14.48 | 12.63 | pass |
| `--tk-function`, `--live`, `--omp-mdLink`, `--omp-toolTitle`, `--ansi6` | `#36f9f6` | 13.79 | 14.68 | 12.80 | pass |
| `--tk-type`, `--tk-operator`, `--omp-mdHeading`, `--ansi5` | `#ff7edb` | 7.96 | 8.48 | 7.39 | pass |
| `--tk-string` | `#ff8b39` | 7.74 | 8.24 | 7.19 | pass |
| `--tk-number` | `#f97e72` | 7.10 | 7.56 | 6.59 | pass |
| `--ok`, `--omp-toolDiffAdded`, `--ansi2` | `#72f1b8` | 12.88 | 13.72 | 11.97 | pass |
| `--bad`, `--omp-toolDiffRemoved`, `--ansi1` | `#fe4450` | 5.29 | 5.64 | 4.91 | pass |
| `--accent`, `--tv-cur` | `#ff4fd8` | 6.33 | 6.74 | 5.88 | pass |
| `--a2` | `#ff2e88` | 5.16 | 5.49 | 4.79 | pass |
| `--ansi0` | `#2a1b3d` | 1.14 | 1.21 | 1.06 | near background, as in most palettes (section 4) |
| `--ansi4` | `#6e8bff` | 5.84 | 6.23 | 5.43 | pass |
| `--ansi7` | `#e0d5f0` | 12.85 | 13.68 | 11.93 | pass |
| `--ansi8` (A) | `#6b5a86` | 2.95 | 3.14 | 2.74 | **fail 3** |
| `--ansi8` (D) | `#76649a` | 3.49 | 3.72 | 3.24 | pass 3 only |
| `--ansi15` | `#ffffff` | 18.05 | 19.23 | 16.76 | pass |
| `--tv-cur-ink` on `--tv-cur` | `#1b1030` on `#ff4fd8` | 6.33 | | | pass |

Other measured values: `--tk-comment` on `--code-bg` `#160c29` is 4.69. `--ansi8` (D) on `--code-bg` is 3.63. `--code-bg` against `--tv-bg` is 1.04:1, and `--card` against `--tv-bg` is 1.08:1.

### 7.2 Concrete gaps

1. **No margin on comment contrast, and no check on other surfaces.** SynthWave '84 settled at 4.66 and LaserWave at 4.61 on their editor backgrounds ([3b66c31](https://github.com/robb0wen/synthwave-vscode/commit/3b66c31), [#12](https://github.com/Jaredk3nt/laserwave/issues/12)). `--tk-comment` is 4.51 on `--tv-bg` (pass 4.5 by 0.01), 4.19 on `--card` (fail 4.5, pass 3) and 4.69 on `--code-bg` (pass). Whether Tern draws syntax tokens on `--card` is [unconfirmed]. The comment hue (H261) is the same as the background hue (H261), at S27. SynthWave '84 shifts its comment toward blue (H233 on an H250 background). LaserWave keeps the hue and removes the saturation (S9) on purpose ([#12](https://github.com/Jaredk3nt/laserwave/issues/12)).

2. **No selection color, and no test of comments under a highlight.** Selection is the most reported problem after comments (section 3.2). The palette token list has no selection variable. Whether Tern exposes one is [unconfirmed]. The prototype's selected tree row uses a pink tint. As a 22 % blend over `--tv-bg` (`#4d1e55`), it gives `--t1` 10.74 (pass), `--t3` 3.93 (fail 4.5, pass 3) and `--tk-comment` 3.22 (fail 4.5, pass 3). Over `--card` (`#532261`), `--tk-comment` drops to 2.97 (fail 3). SynthWave '84 fixed the same problem with a lower selection alpha (`#ffffff20`) ([3b66c31](https://github.com/robb0wen/synthwave-vscode/commit/3b66c31)).

3. **ANSI 8 below 3:1 in variant A.** Mature palettes keep ANSI 8 at about 3:1 or more: Dracula 3.03, Outrun Electric 3.56, Synthwave Alpha 3.65 (section 4). zsh-autosuggestions uses `fg=8` ([README](https://github.com/zsh-users/zsh-autosuggestions/blob/master/README.md)). Variant A `#6b5a86` is 2.95 (fail 3). Variant D `#76649a` is 3.49 on `--tv-bg` (pass 3, fail 4.5) and 3.24 on `--card`. ANSI 8 is not body text, so 3:1 is the bar that themes use in practice. No theme source sets 4.5:1 for ANSI 8 [unconfirmed as a rule].

4. **`--t4` fails the non-text minimum.** `--t4` `#5e4b80` is 2.40 on `--tv-bg` and 2.23 on `--card`. The prototype uses it as the fill of the idle status dot (`.dot`) next to the cyan live dot. If the dot is the only signal of the idle state, [SC 1.4.11](https://www.w3.org/TR/WCAG22/#non-text-contrast) asks for 3:1. If `--t4` is only for disabled controls or decoration, WCAG sets no requirement. What Tern uses `--t4` for outside the prototype is [unconfirmed]. Tokyo Night keeps some UI text at low contrast on purpose, but it publishes a higher-contrast settings block in its README ([README](https://github.com/tokyo-night/tokyo-night-vscode-theme/blob/master/README.md)).

5. **No dim structural tier in syntax.** `--tk-operator` is `#ff7edb` at 7.96, the same color as `--tk-type` and `--omp-mdHeading`. LaserWave gives punctuation a dim `#7b6995` (3.20) and makes it the most used token color ([theme](https://github.com/Jaredk3nt/laserwave/blob/master/themes/LaserWave-color-theme.json)). SynthWave '84 gives separators `#b6b1b1`. Radical states a "low intensity" rule ([THEME.md](https://github.com/dhedgecock/radical-vscode/blob/main/assets/THEME.md)). In the current palette, six of the seven `--tk-*` colors are above 7:1. The only quiet token is the comment.

6. **One neon carries many roles.** Cyan `#36f9f6` is function, link, tool title, live state and ANSI 6. Yellow `#fede5d` is keyword, inline code, warning and ANSI 3. Pink `#ff7edb` is type, operator, heading and ANSI 5. Red `#fe4450` is error, diff removed and ANSI 1. tokyonight.nvim keeps syntax red, error red and git-delete red apart (`#f7768e`, `#db4b4b`, `#914c54`) ([storm.lua](https://github.com/folke/tokyonight.nvim/blob/main/lua/tokyonight/colors/storm.lua)). Contrast is not the problem here (all pass). The problem is meaning: a cyan word can be code, a link, a title or a status.

7. **Glow strength and glow count.** SynthWave '84 chrome glow is `#fc28a825` (about 15 % alpha) on one active element per group ([editor_chrome.css](https://github.com/robb0wen/synthwave-vscode/blob/master/src/css/editor_chrome.css)). Variant D uses the full `var(--accent)` in `0 0 30px -8px` on the composer, `var(--live)` in `0 0 22px -10px` on every `.sf-tool.card`, and `var(--accent)` in `0 8px 18px -10px` on the active tab. A chat with many tool cards gets many glows. The SynthWave '84 author warns that glow is "not intended for extended use" ([README](https://github.com/robb0wen/synthwave-vscode/blob/master/README.md)). No contrast ratio applies to a glow halo.

8. **No non-italic path.** The prototype sets italic on `.thought`, `.recap` and the composer placeholder (`.ph`), all in `--t3` (5.51, pass). Every mature retro theme with italics has had to publish a way to turn them off (section 5). A Tern theme is one CSS file, so the only path is an edit or a second file [inference].

9. **No high-contrast or calmer sibling.** Outrun, LaserWave, Shades of Purple and Cyberpunk all ship a second dark variant because one palette cannot please both the "too dim" users and the "too bright" users (section 1.1). The current set has one dark palette.

10. **Background saturation at the high end.** `--tv-bg` is S50 and `--page` is S55. The calm reference themes are S15 to S20 (section 1.1). Outrun Night and Electric, at S48 and S52, are the closest match, and Outrun calls Electric the "high-contrast" option ([CHANGELOG](https://github.com/samrap/outrun-theme-vscode/blob/master/CHANGELOG.md)). This is a fact for comparison, not a contrast failure.

### 7.3 What the current palette already does well

- Bright ANSI colors differ from the normal ones (9–14 against 1–6). This avoids [tokyonight.nvim #540](https://github.com/folke/tokyonight.nvim/issues/540).
- ANSI blue `#6e8bff` and cyan `#36f9f6` are different. This avoids the SynthWave '84 and Fluoromachine slot collisions (section 3.5).
- All 16 ANSI slots are set. This avoids the missing-slot problem of SynthWave '84 and LaserWave.
- ANSI 0 is a near-background shade (1.14), the most common choice (section 4).
- The UI chrome (`--page`) is darker than the terminal (`--tv-bg`), as in SynthWave '84 and Tokyo Night.
- Diff text on the prototype's 8 % diff tint passes: removed `#fe4450` on `#2d1433` is 4.89, added `#72f1b8` on `#22223b` is 11.02. The reference themes use 10 % to 25 % tints (section 3.4).
- The animated sun is gone and the grid is static. This matches the SynthWave '84 author's reason to refuse animated glow ([#161](https://github.com/robb0wen/synthwave-vscode/issues/161)).

---

## Sources

WCAG

- WCAG 2.2, contrast ratio definition: https://www.w3.org/TR/WCAG22/#dfn-contrast-ratio
- WCAG 2.2, relative luminance definition: https://www.w3.org/TR/WCAG22/#dfn-relative-luminance
- WCAG 2.2, SC 1.4.3 Contrast (Minimum): https://www.w3.org/TR/WCAG22/#contrast-minimum
- WCAG 2.2, SC 1.4.6 Contrast (Enhanced): https://www.w3.org/TR/WCAG22/#contrast-enhanced
- WCAG 2.2, SC 1.4.11 Non-text Contrast: https://www.w3.org/TR/WCAG22/#non-text-contrast
- WCAG 2.2, large scale text definition: https://www.w3.org/TR/WCAG22/#dfn-large-scale

SynthWave '84 (robb0wen/synthwave-vscode)

- README: https://github.com/robb0wen/synthwave-vscode/blob/master/README.md
- Theme file: https://github.com/robb0wen/synthwave-vscode/blob/master/themes/synthwave-color-theme.json
- Glow template: https://github.com/robb0wen/synthwave-vscode/blob/master/src/js/theme_template.js
- Extension code: https://github.com/robb0wen/synthwave-vscode/blob/master/src/extension.js
- Chrome CSS: https://github.com/robb0wen/synthwave-vscode/blob/master/src/css/editor_chrome.css
- Commits: https://github.com/robb0wen/synthwave-vscode/commit/3b66c31 (Fix low contrast comments), https://github.com/robb0wen/synthwave-vscode/commit/970e145 (Minor colour tweaks)
- Issues: [#1](https://github.com/robb0wen/synthwave-vscode/issues/1), [#2](https://github.com/robb0wen/synthwave-vscode/issues/2), [#15](https://github.com/robb0wen/synthwave-vscode/issues/15), [#43](https://github.com/robb0wen/synthwave-vscode/issues/43), [#52](https://github.com/robb0wen/synthwave-vscode/issues/52), [#68](https://github.com/robb0wen/synthwave-vscode/issues/68), [#75](https://github.com/robb0wen/synthwave-vscode/issues/75), [#106](https://github.com/robb0wen/synthwave-vscode/issues/106), [#124](https://github.com/robb0wen/synthwave-vscode/issues/124), [#161](https://github.com/robb0wen/synthwave-vscode/issues/161), [#167](https://github.com/robb0wen/synthwave-vscode/issues/167), [#200](https://github.com/robb0wen/synthwave-vscode/issues/200), [#210](https://github.com/robb0wen/synthwave-vscode/issues/210), [#211](https://github.com/robb0wen/synthwave-vscode/issues/211), [#216](https://github.com/robb0wen/synthwave-vscode/issues/216), [#269](https://github.com/robb0wen/synthwave-vscode/issues/269), [#300](https://github.com/robb0wen/synthwave-vscode/issues/300), [#333](https://github.com/robb0wen/synthwave-vscode/issues/333), [#354](https://github.com/robb0wen/synthwave-vscode/issues/354), [#362](https://github.com/robb0wen/synthwave-vscode/issues/362)

Outrun (samrap/outrun-theme-vscode)

- README: https://github.com/samrap/outrun-theme-vscode/blob/master/README.md
- CHANGELOG: https://github.com/samrap/outrun-theme-vscode/blob/master/CHANGELOG.md
- package.json: https://github.com/samrap/outrun-theme-vscode/blob/master/package.json
- Themes: [Night](https://github.com/samrap/outrun-theme-vscode/blob/master/themes/outrun-night-color-theme.json), [Electric](https://github.com/samrap/outrun-theme-vscode/blob/master/themes/outrun-electric-color-theme.json), [Day](https://github.com/samrap/outrun-theme-vscode/blob/master/themes/outrun-day-color-theme.json)
- Issues: [#7](https://github.com/samrap/outrun-theme-vscode/issues/7), [#13](https://github.com/samrap/outrun-theme-vscode/issues/13)

LaserWave (Jaredk3nt/laserwave)

- README: https://github.com/Jaredk3nt/laserwave/blob/master/README.md
- CHANGELOG: https://github.com/Jaredk3nt/laserwave/blob/master/CHANGELOG.md
- Themes: [LaserWave](https://github.com/Jaredk3nt/laserwave/blob/master/themes/LaserWave-color-theme.json), [High Contrast](https://github.com/Jaredk3nt/laserwave/blob/master/themes/LaserWave-high-contrast-color-theme.json)
- Issues: [#12](https://github.com/Jaredk3nt/laserwave/issues/12), [#37](https://github.com/Jaredk3nt/laserwave/issues/37), [#48](https://github.com/Jaredk3nt/laserwave/issues/48)

Cyberpunk (prometheux-ar/cyberpunk)

- README: https://github.com/prometheux-ar/cyberpunk/blob/master/README.md
- Themes: [Cyberpunk](https://github.com/prometheux-ar/cyberpunk/blob/master/themes/cyberpunk-color-theme.json), [Umbra](https://github.com/prometheux-ar/cyberpunk/blob/master/themes/cyberpunk-umbra-color-theme.json)
- Issue: [#115](https://github.com/prometheux-ar/cyberpunk/issues/115)

Shades of Purple (ahmadawais/shades-of-purple-vscode)

- readme: https://github.com/ahmadawais/shades-of-purple-vscode/blob/master/readme.md
- Themes: [normal](https://github.com/ahmadawais/shades-of-purple-vscode/blob/master/themes/shades-of-purple-color-theme.json), [Super Dark](https://github.com/ahmadawais/shades-of-purple-vscode/blob/master/themes/shades-of-purple-color-theme-super-dark.json)
- Issues: [#6](https://github.com/ahmadawais/shades-of-purple-vscode/issues/6), [#13](https://github.com/ahmadawais/shades-of-purple-vscode/issues/13), [#149](https://github.com/ahmadawais/shades-of-purple-vscode/issues/149)

Tokyo Night (tokyo-night/tokyo-night-vscode-theme)

- README: https://github.com/tokyo-night/tokyo-night-vscode-theme/blob/master/README.md
- CHANGELOG: https://github.com/tokyo-night/tokyo-night-vscode-theme/blob/master/CHANGELOG.md
- Themes: [Tokyo Night](https://github.com/tokyo-night/tokyo-night-vscode-theme/blob/master/themes/tokyo-night-color-theme.json), [Light](https://github.com/tokyo-night/tokyo-night-vscode-theme/blob/master/themes/tokyo-night-light-color-theme.json)
- Issues: [#25](https://github.com/tokyo-night/tokyo-night-vscode-theme/issues/25), [#33](https://github.com/tokyo-night/tokyo-night-vscode-theme/issues/33), [#55](https://github.com/tokyo-night/tokyo-night-vscode-theme/issues/55), [#68](https://github.com/tokyo-night/tokyo-night-vscode-theme/issues/68), [#88](https://github.com/tokyo-night/tokyo-night-vscode-theme/issues/88), [#99](https://github.com/tokyo-night/tokyo-night-vscode-theme/issues/99)

tokyonight.nvim (folke/tokyonight.nvim)

- README: https://github.com/folke/tokyonight.nvim/blob/main/README.md
- Palette: https://github.com/folke/tokyonight.nvim/blob/main/lua/tokyonight/colors/storm.lua
- Derived colors and terminal mapping: https://github.com/folke/tokyonight.nvim/blob/main/lua/tokyonight/colors/init.lua
- Day generation: https://github.com/folke/tokyonight.nvim/blob/main/lua/tokyonight/colors/day.lua
- Color utilities (invert, brighten): https://github.com/folke/tokyonight.nvim/blob/main/lua/tokyonight/util.lua
- Issues: [#25](https://github.com/folke/tokyonight.nvim/issues/25), [#28](https://github.com/folke/tokyonight.nvim/issues/28), [#435](https://github.com/folke/tokyonight.nvim/issues/435), [#540](https://github.com/folke/tokyonight.nvim/issues/540)

Horizon (jolaleye/horizon-theme-vscode, archived)

- README: https://github.com/jolaleye/horizon-theme-vscode/blob/master/README.md
- CHANGELOG: https://github.com/jolaleye/horizon-theme-vscode/blob/master/CHANGELOG.md
- Themes: [Horizon](https://github.com/jolaleye/horizon-theme-vscode/blob/master/themes/horizon.json), [Horizon Bright](https://github.com/jolaleye/horizon-theme-vscode/blob/master/themes/horizon-bright.json)

Radical (dhedgecock/radical-vscode)

- Design notes: https://github.com/dhedgecock/radical-vscode/blob/main/assets/THEME.md
- Implementation notes: https://github.com/dhedgecock/radical-vscode/blob/main/assets/NOTES.md
- Theme: https://github.com/dhedgecock/radical-vscode/blob/main/dist/Radical.json

SynthWave x Fluoromachine (webrender/synthwave-x-fluoromachine)

- README: https://github.com/webrender/synthwave-x-fluoromachine/blob/master/README.md
- Theme: https://github.com/webrender/synthwave-x-fluoromachine/blob/master/themes/synthwave-x-fluoromachine.json

Fairy Floss (sailorhg/fairyfloss)

- tmTheme: https://github.com/sailorhg/fairyfloss/blob/gh-pages/fairyfloss.tmTheme

iTerm2-Color-Schemes (mbadolato/iTerm2-Color-Schemes)

- Ghostty palettes folder: https://github.com/mbadolato/iTerm2-Color-Schemes/tree/master/ghostty (files linked one by one in section 4)
- Issues: [#578](https://github.com/mbadolato/iTerm2-Color-Schemes/issues/578), [#606](https://github.com/mbadolato/iTerm2-Color-Schemes/issues/606)

Tools

- zsh-autosuggestions README (default `fg=8`): https://github.com/zsh-users/zsh-autosuggestions/blob/master/README.md
