# Omarchy: theme system and design rules, for Night Drive

Research date: 2026-11-09. Scope: the Omarchy theme system, the Omarchy desktop design rules, and the Herdr copy of the Omarchy look. The goal is to find ideas for the Tern theme Night Drive (`themes/night-drive.css`). This file is research, not design.

Method. I read the source files with `gh api` and `raw.githubusercontent.com`. I did not install or run Omarchy or Herdr. All links point to fixed commits or tags, so the line numbers stay correct.

Versions. `github.com/basecamp/omarchy` now redirects to [`omacom/omarchy`](https://github.com/omacom/omarchy/blob/v4.5.0/README.md). The default branch is `quattro` (Omarchy 4). I use these snapshots:

- **Omarchy 4.5.0**: tag `v4.5.0`, commit `ac2690c`, released 2026-11-05. This is the main source. Omarchy 4 has no Waybar, Walker or Mako. One Quickshell program, the "Omarchy shell", draws the bar, the menu, the notifications, the OSD and the lock screen ([manual 05](https://github.com/omacom/omarchy/blob/v4.5.0/manual/05-the-top-bar.md#L3)). The Hyprland config is Lua.
- **Omarchy `quattro` head**: commit `b99593e`. I use it only for `default/themed/herdr-app.json.tpl`. Commit [`4907fcd`](https://github.com/omacom/omarchy/commit/4907fcdf74eb5d3de6b33a02a9e3c972624f5881) added that file on 2026-11-02, and the `v4.5.0` tag does not contain it.
- **Omarchy 3.8.5**: branch `master`, commit `f4378f0`. I use it for the Waybar, Walker and Mako values that the task asks for, because Omarchy 4 removed these programs.
- **herdr-omarchy**: commit `2c8c985` of [shafiqimtiaz/herdr-omarchy](https://github.com/shafiqimtiaz/herdr-omarchy/blob/2c8c9857601599c3575d1b5e6f2bb48e335d178d/README.md).
- **Herdr app**: commit `b721ded` of [herdrdev/herdr-app](https://github.com/herdrdev/herdr-app/blob/b721deda985270ec8256552692729a4add389b2a/defaults/AGENTS.md), for the meaning of the Herdr theme keys.

The manual. The Omarchy README says that the `manual/` folder in the repo is the authoritative source of the manual ([README](https://github.com/omacom/omarchy/blob/v4.5.0/README.md)). I read the manual there. I did not read learn.omacom.io, so any difference between the two is [unconfirmed].

Tern side. The Tern variable names come from the task context and from `night-drive.css`. Tern has no public documentation for these variables that I could find. When I say what a Tern variable colors, I use its name and its use in `night-drive.css`. Where that is a guess, I mark it [inference].

---

## Top 5 findings

1. **One palette file colors the whole desktop.** A theme is one `colors.toml` with 26 named tokens ([manual 43](https://github.com/omacom/omarchy/blob/v4.5.0/manual/43-making-your-own-theme.md#L5)). A script fills `{{ token }}` placeholders in the 20 templates of [`default/themed/`](https://github.com/omacom/omarchy/blob/v4.5.0/default/themed), one per program. The script also makes missing tokens from other tokens, with fixed mix rules: for example, `dark_background` is `background` mixed 25 % with black ([omarchy-theme-color](https://github.com/omacom/omarchy/blob/v4.5.0/bin/omarchy-theme-color#L236-L243)). The Herdr template uses only 4 base keys, the 16 ANSI colors and 4 UI colors (section 2).
2. **The window design is square, framed and flat.** Corners are square ("Omarchy's default design is one of square corners", [manual 42](https://github.com/omacom/omarchy/blob/v4.5.0/manual/42-common-tweaks.md#L13)). Every window has a 2 px border. Inner gaps are 5 px and outer gaps are 10 px. Omarchy 4 has no shadow and no blur by default ([looknfeel.lua](https://github.com/omacom/omarchy/blob/v4.5.0/default/hypr/looknfeel.lua#L6-L34)). The border color marks the focused window: the theme accent on the active window, `rgba(595959aa)` on the others ([hyprland.lua.tpl](https://github.com/omacom/omarchy/blob/v4.5.0/default/themed/hyprland.lua.tpl#L1-L2)). Terminals also change opacity, from 0.985 (active) to 0.96 (inactive) ([helpers.lua](https://github.com/omacom/omarchy/blob/v4.5.0/default/hypr/helpers.lua#L326-L328)).
3. **States are foreground tints at fixed alphas, not new colors.** Shell controls use the foreground color at 4 % (rest), 8 % (hover), 18 % (selected), 22 % (pressed) and 35 % (text selection). A 1 px border at 40 % (rest) or 25 % (hover) goes with them, and the selected state has no border ([shell.toml.tpl](https://github.com/omacom/omarchy/blob/v4.5.0/default/themed/shell.toml.tpl#L26-L65)). Night Drive already uses 8 % for tab hover and 18 % for the active tab. It has no rest, pressed or hover-border state.
4. **One monospace font everywhere, at small sizes.** JetBrainsMono Nerd Font is the terminal font and the system font ([manual 38](https://github.com/omacom/omarchy/blob/v4.5.0/manual/38-fonts.md#L3)). Terminals use size 9 and 14 px padding ([alacritty.toml](https://github.com/omacom/omarchy/blob/v4.5.0/config/alacritty/alacritty.toml#L9-L17)). The shell text scale is 12 px at its base ([shell.toml.tpl](https://github.com/omacom/omarchy/blob/v4.5.0/default/themed/shell.toml.tpl#L101-L106)). The top bar is 26 px high ([shell.toml.tpl](https://github.com/omacom/omarchy/blob/v4.5.0/default/themed/shell.toml.tpl#L12-L17)). The Herdr copy uses CaskaydiaMono Nerd Font, a 30 px top bar and 12 px terminal padding ([RECIPE.md](https://github.com/shafiqimtiaz/herdr-omarchy/blob/2c8c9857601599c3575d1b5e6f2bb48e335d178d/RECIPE.md#L11), [layouts/omarchy.json](https://github.com/shafiqimtiaz/herdr-omarchy/blob/2c8c9857601599c3575d1b5e6f2bb48e335d178d/layouts/omarchy.json#L10-L19)).
5. **No Omarchy theme is a pink and cyan synthwave palette.** Omarchy 4.5.0 has 23 themes. The 3 closest to an 80s or neon palette are Retro 82 (orange and teal on navy), Tokyo Night (blue, violet and pink on blue-black) and Hackerman (neon green and cyan on near-black) (section 4). So Omarchy gives Night Drive structure and rules, but not colors.

---

## 1. Theme structure

### 1.1 Files in one theme

A user theme is a folder in `~/.config/omarchy/themes`. The main file is `colors.toml` ([manual 43](https://github.com/omacom/omarchy/blob/v4.5.0/manual/43-making-your-own-theme.md#L3-L5)). The table lists every file name that occurs in the 23 theme folders of v4.5.0 (from the git tree of tag `v4.5.0`).

| File | In how many themes | What it does | Source |
|---|---|---|---|
| `colors.toml` | 23 of 23 | The palette. Omarchy makes the configs for the terminals, btop, Chromium, Hyprland, Neovim, Helix, VS Code, Obsidian and the Omarchy shell from it. | [manual 43](https://github.com/omacom/omarchy/blob/v4.5.0/manual/43-making-your-own-theme.md#L5) |
| `backgrounds/` | 23 | Wallpapers. `Super + Ctrl + W` changes between them. | [manual 06](https://github.com/omacom/omarchy/blob/v4.5.0/manual/06-themes.md#L7) |
| `preview.png` | 23 | The picture in the theme picker. | [manual 06](https://github.com/omacom/omarchy/blob/v4.5.0/manual/06-themes.md#L11-L12) |
| `icons.theme` | 22 | The name of the icon set, for example `Yaru-magenta`. | [manual 43](https://github.com/omacom/omarchy/blob/v4.5.0/manual/43-making-your-own-theme.md#L23-L25), [tokyo-night/icons.theme](https://github.com/omacom/omarchy/blob/v4.5.0/themes/tokyo-night/icons.theme) |
| `unlock.png`, `preview-unlock.png` | 22 | The boot unlock design and its preview. | [manual 43](https://github.com/omacom/omarchy/blob/v4.5.0/manual/43-making-your-own-theme.md#L27-L29) |
| `neovim.lua` | 14 | A Neovim colorscheme plugin spec. It replaces the generated one. | [tokyo-night/neovim.lua](https://github.com/omacom/omarchy/blob/v4.5.0/themes/tokyo-night/neovim.lua) |
| `vscode.json` | 15 | The name of a VS Code theme extension to install. | [tokyo-night/vscode.json](https://github.com/omacom/omarchy/blob/v4.5.0/themes/tokyo-night/vscode.json), [manual 43](https://github.com/omacom/omarchy/blob/v4.5.0/manual/43-making-your-own-theme.md#L13) |
| `hyprland.lua` | 5 (kanagawa, last-horizon, lumon, retro-82, solitude) | A hand-written Hyprland override, for example the border color, a shadow or rounding. | [retro-82/hyprland.lua](https://github.com/omacom/omarchy/blob/v4.5.0/themes/retro-82/hyprland.lua) |
| `chromium.theme` | 5 | A hand-written browser color. | [omarchy tree, tag v4.5.0](https://github.com/omacom/omarchy/blob/v4.5.0/themes) |
| `btop.theme` | 4 | A hand-written btop theme. | [omarchy tree, tag v4.5.0](https://github.com/omacom/omarchy/blob/v4.5.0/themes) |
| `keyboard.rgb` | 1 (tokyo-night) | The keyboard backlight color, `ff00ff`. | [tokyo-night/keyboard.rgb](https://github.com/omacom/omarchy/blob/v4.5.0/themes/tokyo-night/keyboard.rgb) |
| `shell.lock.toml` | 1 (tokyo-night) | Replaces one section (`[lock]`) of the generated `shell.toml`. | [tokyo-night/shell.lock.toml](https://github.com/omacom/omarchy/blob/v4.5.0/themes/tokyo-night/shell.lock.toml), [omarchy-theme-set-templates](https://github.com/omacom/omarchy/blob/v4.5.0/bin/omarchy-theme-set-templates#L306-L316) |
| `shell.toml` | 0 | A theme can ship it to replace the whole generated shell file. | [shell.toml.tpl](https://github.com/omacom/omarchy/blob/v4.5.0/default/themed/shell.toml.tpl#L1-L3) |
| `light.mode` | 0 | Old way to mark a light theme. `mode = "light"` in `colors.toml` replaces it. | [manual 43](https://github.com/omacom/omarchy/blob/v4.5.0/manual/43-making-your-own-theme.md#L19-L21) |

Rule: a file that the theme ships wins over the generated file with the same name. The script does not overwrite configs that the theme already ships ([omarchy-theme-set-templates](https://github.com/omacom/omarchy/blob/v4.5.0/bin/omarchy-theme-set-templates#L319-L331)). A theme installed from a git repo loses its `.lua` files, its terminal configs and `vscode.json`, because these can run code ([manual 43](https://github.com/omacom/omarchy/blob/v4.5.0/manual/43-making-your-own-theme.md#L13-L17), [omarchy-theme-set](https://github.com/omacom/omarchy/blob/v4.5.0/bin/omarchy-theme-set#L35)).

### 1.2 Color tokens in `colors.toml`

All 23 themes in v4.5.0 use the same 26 keys. Three themes (last-horizon, solitude, white) leave out `orange` and `brown`. Four optional keys also occur (see the end of the table). The "Colors" column comes from the templates in `default/themed/` that use the token (I searched all 20 templates of v4.5.0 for each token). The "Tern" column is my mapping to Night Drive [inference].

| Token | Colors | Default when the theme leaves it out | Closest Tern variable |
|---|---|---|---|
| `mode` | `dark` or `light`. Pairs the apps with dark or light mode ([manual 43](https://github.com/omacom/omarchy/blob/v4.5.0/manual/43-making-your-own-theme.md#L21)). | The background luminance decides: a sum of R+G+B above 382 gives light ([omarchy-theme-color](https://github.com/omacom/omarchy/blob/v4.5.0/bin/omarchy-theme-color#L120-L134)). | `color-scheme` |
| `accent` | The active window border (when the theme sets no `hyprland_active_border`), the borders of shell popups and notifications, the selected text in menus, kitty active tab, btop highlights, Herdr `accent` and `solid`. ([hyprland.lua.tpl](https://github.com/omacom/omarchy/blob/v4.5.0/default/themed/hyprland.lua.tpl#L1), [shell.toml.tpl](https://github.com/omacom/omarchy/blob/v4.5.0/default/themed/shell.toml.tpl#L19-L24), [kitty.conf.tpl](https://github.com/omacom/omarchy/blob/v4.5.0/default/themed/kitty.conf.tpl), [btop.theme.tpl](https://github.com/omacom/omarchy/blob/v4.5.0/default/themed/btop.theme.tpl)) | none | `--accent` |
| `selection` | The selection background. `selection_background` is the same value. btop selected row and meter background. ([btop.theme.tpl](https://github.com/omacom/omarchy/blob/v4.5.0/default/themed/btop.theme.tpl)) | `selection_background`, else ANSI 8, else the background ([omarchy-theme-color](https://github.com/omacom/omarchy/blob/v4.5.0/bin/omarchy-theme-color#L229-L230)) | `--tv-sel` |
| `selection_foreground` (derived) | Text in a terminal selection ([ghostty.conf.tpl](https://github.com/omacom/omarchy/blob/v4.5.0/default/themed/ghostty.conf.tpl)). | `bright_foreground` ([omarchy-theme-color](https://github.com/omacom/omarchy/blob/v4.5.0/bin/omarchy-theme-color#L231)) | none |
| `muted` | ANSI 8 (bright black), btop inactive text and divider lines. herdr-omarchy also uses it for every tile `border`. ([ghostty.conf.tpl](https://github.com/omacom/omarchy/blob/v4.5.0/default/themed/ghostty.conf.tpl), [RECIPE.md](https://github.com/shafiqimtiaz/herdr-omarchy/blob/2c8c9857601599c3575d1b5e6f2bb48e335d178d/RECIPE.md#L56)) | ANSI 8, else `dark_foreground` | `--ansi8`, `--t4` |
| `background` | Terminal background, ANSI 0, cursor text, the background of the bar, menus, popups and notifications, Herdr `accent_foreground`. ([ghostty.conf.tpl](https://github.com/omacom/omarchy/blob/v4.5.0/default/themed/ghostty.conf.tpl), [shell.toml.tpl](https://github.com/omacom/omarchy/blob/v4.5.0/default/themed/shell.toml.tpl#L7)) | ANSI 0 | `--tv-bg` |
| `dark_background` | Neovim `dark_bg`, the t3code sidebar, the Hermes status bar. herdr-omarchy uses it for `canvas` and `chrome`. ([neovim.lua.tpl](https://github.com/omacom/omarchy/blob/v4.5.0/default/themed/neovim.lua.tpl#L10), [t3code.json.tpl](https://github.com/omacom/omarchy/blob/v4.5.0/default/themed/t3code.json.tpl#L16), [RECIPE.md](https://github.com/shafiqimtiaz/herdr-omarchy/blob/2c8c9857601599c3575d1b5e6f2bb48e335d178d/RECIPE.md#L56)) | `background` mixed 25 % with black ([omarchy-theme-color](https://github.com/omacom/omarchy/blob/v4.5.0/bin/omarchy-theme-color#L236)) | `--page` |
| `darker_background` | Neovim `darker_bg` only. | `background` mixed 50 % with black | `--code-bg` [inference] |
| `lighter_background` | The btop graph gradient, the Helix cursor line and ruler, the Hermes completion menu. ([helix.toml.tpl](https://github.com/omacom/omarchy/blob/v4.5.0/default/themed/helix.toml.tpl#L79-L99)) | ANSI 0, else `background` | `--card` |
| `foreground` | Terminal text, ANSI 7, the text of the bar, menus and popups, the tint of all shell control states. | ANSI 7 | `--tv-fg`, `--ink`, `--t1` |
| `dark_foreground` | Dim text: btop gradient, VS Code disabled text, Hermes "thinking" text. ([hermes.yaml.tpl](https://github.com/omacom/omarchy/blob/v4.5.0/default/themed/hermes.yaml.tpl#L14)) | ANSI 8, else `foreground` | `--t3` |
| `light_foreground` | btop graph text and process details. | ANSI 7, else `foreground` | `--t2` |
| `bright_foreground` | ANSI 15 and the cursor in every terminal and in Herdr. | ANSI 15, else `foreground` ([omarchy-theme-color](https://github.com/omacom/omarchy/blob/v4.5.0/bin/omarchy-theme-color#L223-L225)) | `--ansi15`; Omarchy has no separate cursor token |
| `red`, `green`, `yellow`, `blue`, `magenta`, `cyan` | ANSI 1 to 6. `red` is also the bar color for alerts (recording, updates) and the error color of the lock and polkit prompts. ([shell.toml.tpl](https://github.com/omacom/omarchy/blob/v4.5.0/default/themed/shell.toml.tpl#L10-L11)) | ANSI 1 to 6 | `--ansi1` to `--ansi6`; `red` also `--bad` |
| `orange` | VS Code numbers, booleans and modified files; Neovim. ([vscode-theme.json.tpl](https://github.com/omacom/omarchy/blob/v4.5.0/default/themed/vscode-theme.json.tpl#L36-L37)) | `yellow` | `--tk-number` [inference] |
| `brown` | Neovim only. | `orange` mixed 50 % with black | none |
| `bright_red` ... `bright_magenta` | ANSI 9 to 14. | The base color mixed 20 % with white ([omarchy-theme-color](https://github.com/omacom/omarchy/blob/v4.5.0/bin/omarchy-theme-color#L238-L243)) | `--ansi9` to `--ansi14` |
| `hyprland_active_border` (optional) | The active window border. Can be a gradient, for example `rgba(26a269ee) rgba(2ec27eee) 45deg` in Hackerman. It also feeds the shell border tokens. ([hackerman/colors.toml](https://github.com/omacom/omarchy/blob/v4.5.0/themes/hackerman/colors.toml), [shell.toml.tpl](https://github.com/omacom/omarchy/blob/v4.5.0/default/themed/shell.toml.tpl#L23-L24)) | `accent` | none |
| `hyprland_inactive_border` (optional) | The inactive window border. | `rgba(595959aa)` ([hyprland.lua.tpl](https://github.com/omacom/omarchy/blob/v4.5.0/default/themed/hyprland.lua.tpl#L2)) | none |
| `active_border_color`, `active_tab_background` (optional) | Present in last-horizon, lumon and solitude. No v4.5.0 template reads them (my search of `default/themed/` found no use). | none | none |

Old names still work. A theme can use `bg`, `fg` and the other short names, or only `color0` to `color15`. The script maps them to the semantic names ([omarchy-theme-color](https://github.com/omacom/omarchy/blob/v4.5.0/bin/omarchy-theme-color#L180-L218)). Omarchy 3.8.5 themes used `color0` to `color15` plus `accent`, `cursor`, `foreground`, `background`, `selection_foreground` and `selection_background` ([3.8.5 retro-82/colors.toml](https://github.com/omacom/omarchy/blob/f4378f0de5b44d331ee943746a97872b718a6c18/themes/retro-82/colors.toml)).

---

## 2. How the templates turn tokens into app configs

### 2.1 The mechanism

1. `omarchy-theme-set` copies the theme to a staging folder. Then `omarchy-theme-set-templates` reads `colors.toml` through `omarchy-theme-color --all`. That command fills every missing token with the rules in section 1.2 ([omarchy-theme-set-templates](https://github.com/omacom/omarchy/blob/v4.5.0/bin/omarchy-theme-set-templates#L429-L447)).
2. Each template is a config file with placeholders. The output file has the template name without `.tpl`. For example, `ghostty.conf.tpl` gives `ghostty.conf` ([omarchy-theme-set-templates](https://github.com/omacom/omarchy/blob/v4.5.0/bin/omarchy-theme-set-templates#L319-L331)).
3. Placeholder forms ([alacritty.toml.tpl.sample](https://github.com/omacom/omarchy/blob/v4.5.0/config/omarchy/themed/alacritty.toml.tpl.sample), [omarchy-theme-set-templates](https://github.com/omacom/omarchy/blob/v4.5.0/bin/omarchy-theme-set-templates#L162-L171)):
   - `{{ token }}` gives `#rrggbb`.
   - `{{ token_strip }}` gives the hex value without `#`.
   - `{{ token_rgb }}` gives decimal `r,g,b`.
   - `{{ mix a b 34% }}` mixes two tokens. `[lock] placeholder` uses `{{ mix foreground background 34% }}` ([shell.toml.tpl](https://github.com/omacom/omarchy/blob/v4.5.0/default/themed/shell.toml.tpl#L216)).
   - `{{ hypr_gradient key fallback }}` and `{{ shell_gradient key fallback }}` turn a gradient string into Hyprland Lua or shell syntax ([omarchy-theme-set-templates](https://github.com/omacom/omarchy/blob/v4.5.0/bin/omarchy-theme-set-templates#L18)).
4. User templates in `~/.config/omarchy/themed/` win over the built-in ones. A user can add a template for any program ([manual 43](https://github.com/omacom/omarchy/blob/v4.5.0/manual/43-making-your-own-theme.md#L31-L35)).

The terminal rule is the same in every terminal template: ANSI 0 = `background`, ANSI 7 = `foreground`, ANSI 8 = `muted`, ANSI 15 = `bright_foreground`, cursor = `bright_foreground`, cursor text = `background` ([ghostty.conf.tpl](https://github.com/omacom/omarchy/blob/v4.5.0/default/themed/ghostty.conf.tpl), [kitty.conf.tpl](https://github.com/omacom/omarchy/blob/v4.5.0/default/themed/kitty.conf.tpl)).

The shell template `shell.toml.tpl` is the most useful one for Tern, because it holds the UI rules and not only colors. Section 3 lists its values.

### 2.2 The Herdr template, in full

Source: [`default/themed/herdr-app.json.tpl`](https://github.com/omacom/omarchy/blob/b99593ed3c5d104210394669efc88a684f76ddbf/default/themed/herdr-app.json.tpl) (on `quattro` after v4.5.0). The script `omarchy-theme-set-herdr-app` checks that `background`, `foreground`, `selection` and `cursor` are `#rrggbb`, that `ansi` has 16 colors, and that every value in `colors` is a color. Then it writes the file to `~/.config/herdr-app/themes/omarchy.json` ([omarchy-theme-set-herdr-app](https://github.com/omacom/omarchy/blob/b99593ed3c5d104210394669efc88a684f76ddbf/bin/omarchy-theme-set-herdr-app#L20-L76)).

```json
{
  "background": "{{ background }}",
  "foreground": "{{ foreground }}",
  "selection": "{{ selection_background }}",
  "cursor": "{{ bright_foreground }}",
  "ansi": [
    "{{ background }}", "{{ red }}", "{{ green }}", "{{ yellow }}",
    "{{ blue }}", "{{ magenta }}", "{{ cyan }}", "{{ foreground }}",
    "{{ muted }}", "{{ bright_red }}", "{{ bright_green }}", "{{ bright_yellow }}",
    "{{ bright_blue }}", "{{ bright_magenta }}", "{{ bright_cyan }}", "{{ bright_foreground }}"
  ],
  "colors": {
    "accent": "{{ accent }}",
    "accent_foreground": "{{ background }}",
    "solid": "{{ accent }}",
    "solid_foreground": "{{ background }}"
  }
}
```

herdr-omarchy ships the 23 themes rendered through this template, and adds 3 keys: `canvas` and `chrome` = `dark_background`, `border` = `muted` ([RECIPE.md](https://github.com/shafiqimtiaz/herdr-omarchy/blob/2c8c9857601599c3575d1b5e6f2bb48e335d178d/RECIPE.md#L56)). Example output for Retro 82 ([themes/retro-82.json](https://github.com/shafiqimtiaz/herdr-omarchy/blob/2c8c9857601599c3575d1b5e6f2bb48e335d178d/themes/retro-82.json)):

```json
{
  "background": "#05182e",
  "foreground": "#f6dcac",
  "selection": "#134e5a",
  "cursor": "#f6dcac",
  "ansi": [
    "#05182e",
    "#f85525",
    "#028391",
    "#e97b3c",
    "#3f8f8a",
    "#3f8f8a",
    "#8cbfb8",
    "#f6dcac",
    "#2a6b78",
    "#f85525",
    "#028391",
    "#e97b3c",
    "#faa968",
    "#3f8f8a",
    "#8cbfb8",
    "#f6dcac"
  ],
  "colors": {
    "accent": "#faa968",
    "accent_foreground": "#05182e",
    "solid": "#faa968",
    "solid_foreground": "#05182e",
    "canvas": "#031222",
    "chrome": "#031222",
    "border": "#2a6b78"
  }
}
```

Note: `themes/tokyo-night.json` in herdr-omarchy is not a render of the v4.5.0 Tokyo Night tokens. Its ANSI list matches the 3.8.5 `color0` to `color15`, and it sets 18 `colors` keys, with `canvas` `#16161e` ([themes/tokyo-night.json](https://github.com/shafiqimtiaz/herdr-omarchy/blob/2c8c9857601599c3575d1b5e6f2bb48e335d178d/themes/tokyo-night.json)). The other 22 files have the 7-key form.

### 2.3 Herdr keys mapped to Tern variables

Herdr key meanings come from the Herdr app guide: the theme file format ([AGENTS.md](https://github.com/herdrdev/herdr-app/blob/b721deda985270ec8256552692729a4add389b2a/defaults/AGENTS.md#L326-L328)) and the list of theme color names that mods can read ([AGENTS.md](https://github.com/herdrdev/herdr-app/blob/b721deda985270ec8256552692729a4add389b2a/defaults/AGENTS.md#L962-L968)). Herdr derives every panel color that a theme does not set from the base keys. The Tern column is my mapping [inference]: Tern publishes no variable reference that I found.

| Omarchy/Herdr key | Value in the template | Meaning in Herdr | Closest Tern variable |
|---|---|---|---|
| `background` | `background` | Terminal background, and the background of cards | `--tv-bg` |
| `foreground` | `foreground` | Terminal text | `--tv-fg` (UI text: `--ink`, `--t1`) |
| `selection` | `selection_background` | Background behind selected text | `--tv-sel` (also `--tv-sel-a`, `--tv-sel-b`) |
| `cursor` | `bright_foreground` | Terminal cursor | `--tv-cur` |
| (none) | (cursor text is `background` in the terminal templates) | Text under a block cursor | `--tv-cur-ink` |
| `ansi[0]` to `ansi[15]` | `background`, `red`, `green`, `yellow`, `blue`, `magenta`, `cyan`, `foreground`, `muted`, `bright_red`, `bright_green`, `bright_yellow`, `bright_blue`, `bright_magenta`, `bright_cyan`, `bright_foreground` | The 16 terminal colors | `--ansi0` to `--ansi15` |
| `colors.accent` | `accent` | Accent color: focus frame, active marks | `--accent` (also `--omp-accent`, `--sf-c-accent`) |
| `colors.accent_foreground` | `background` | Text on an accent fill | none in the list. `--tv-cur-ink` does the same job for the cursor. |
| `colors.solid` | `accent` | Primary button fill | `--accent-fill` (Night Drive defines it) [inference] |
| `colors.solid_foreground` | `background` | Text on a primary button | none |
| `colors.canvas` (herdr-omarchy) | `dark_background` | Behind cards | `--page` |
| `colors.chrome` (herdr-omarchy) | `dark_background` | Sidebars and bars | `--page` (Night Drive paints `#tabbar` with it) |
| `colors.border` (herdr-omarchy) | `muted` | Frames and dividers | none. Night Drive draws frames with `--ink` at 8 % to 12 %. |
| `surface`, `popover`, `raised` (Herdr, derived) | not in the template | Panels, popups, a raised surface | `--card` |
| `hover`, `selected` (Herdr, derived) | not in the template | Hover and selected fills | none. Night Drive uses `--ink` at 8 % and 18 %. |
| `input` (Herdr, derived) | not in the template | "a stronger border" | none |
| `muted` (Herdr, derived) | not in the template | Secondary text | `--t3` (Night Drive sets `--omp-muted` to the same value) |
| `dim` (Herdr, derived) | not in the template | Tertiary text | `--t4` |
| `working` (Herdr, derived) | not in the template | Agent works | `--live` [inference] |
| `blocked` (Herdr, derived) | not in the template | Agent needs the user | `--bad` or `--warn` [unconfirmed which one Tern uses for this state] |
| `done` (Herdr, derived) | not in the template | Agent finished | `--ok` |
| `idle`, `unknown` (Herdr, derived) | not in the template | Agent is idle or has no status | `--t4` [inference] |
| `ring` (Herdr) | not in the template | Focus ring ([win98.json](https://github.com/herdrdev/herdr-app/blob/b721deda985270ec8256552692729a4add389b2a/defaults/themes/win98.json)) | `--accent` |

Omarchy has no tokens for syntax colors (`--tk-*`) or for chat colors (`--omp-*`). Its editors get syntax colors from the ANSI-like tokens (`orange` for numbers in VS Code, for example) or from a theme plugin (`neovim.lua`, `vscode.json`).

---

## 3. Design rules of the desktop

Values are from Omarchy 4.5.0 unless the row says 3.8.5.

### 3.1 Windows (Hyprland)

| Rule | Value | Source |
|---|---|---|
| Border width | 2 px (`border_size = 2`) | [looknfeel.lua](https://github.com/omacom/omarchy/blob/v4.5.0/default/hypr/looknfeel.lua#L10) |
| Active border, built-in default | gradient `rgba(33ccffee)` to `rgba(00ff99ee)`, 45 degrees | [looknfeel.lua](https://github.com/omacom/omarchy/blob/v4.5.0/default/hypr/looknfeel.lua#L3) |
| Active border, with a theme | `hyprland_active_border`, else `accent` (solid). Retro 82 sets `rgb(faa968)`. Last Horizon and Solitude set two-color 45-degree gradients. | [hyprland.lua.tpl](https://github.com/omacom/omarchy/blob/v4.5.0/default/themed/hyprland.lua.tpl#L1), [retro-82/hyprland.lua](https://github.com/omacom/omarchy/blob/v4.5.0/themes/retro-82/hyprland.lua#L1), [solitude/hyprland.lua](https://github.com/omacom/omarchy/blob/v4.5.0/themes/solitude/hyprland.lua#L1) |
| Inactive border | `rgba(595959aa)` (grey at about 67 % alpha), unless the theme sets `hyprland_inactive_border` | [looknfeel.lua](https://github.com/omacom/omarchy/blob/v4.5.0/default/hypr/looknfeel.lua#L4), [hyprland.lua.tpl](https://github.com/omacom/omarchy/blob/v4.5.0/default/themed/hyprland.lua.tpl#L2) |
| Gaps | inner 5 px (`gaps_in`), outer 10 px (`gaps_out`) | [looknfeel.lua](https://github.com/omacom/omarchy/blob/v4.5.0/default/hypr/looknfeel.lua#L8-L9) |
| Shell gap to the screen edge | half of `gaps_out`, so 5 px | [Style.qml](https://github.com/omacom/omarchy/blob/v4.5.0/shell/Commons/Style.qml#L13-L19) |
| Corner rounding | 0. Toggle "rounded" sets 6 with `rounding_power = 3`. Solitude is the only theme with rounding (6). The shell copies the Hyprland rounding. | [looknfeel.lua](https://github.com/omacom/omarchy/blob/v4.5.0/default/hypr/looknfeel.lua#L25), [corners-rounded.lua](https://github.com/omacom/omarchy/blob/v4.5.0/default/hypr/toggles/corners-rounded.lua), [solitude/hyprland.lua](https://github.com/omacom/omarchy/blob/v4.5.0/themes/solitude/hyprland.lua#L17-L20), [Style.qml](https://github.com/omacom/omarchy/blob/v4.5.0/shell/Commons/Style.qml#L13) |
| Shadow | off. Lumon turns it on: range 6, render power 4, color `rgb(6fb8e3)`. | [looknfeel.lua](https://github.com/omacom/omarchy/blob/v4.5.0/default/hypr/looknfeel.lua#L27-L29), [lumon/hyprland.lua](https://github.com/omacom/omarchy/blob/v4.5.0/themes/lumon/hyprland.lua#L21-L28) |
| Blur | off. The "Glassy" toggle turns it on: size 4, passes 2, brightness 0.75, contrast 1.0, noise 0.01, vibrancy 0.35. | [looknfeel.lua](https://github.com/omacom/omarchy/blob/v4.5.0/default/hypr/looknfeel.lua#L31-L33), [glass.lua](https://github.com/omacom/omarchy/blob/v4.5.0/default/hypr/glass.lua#L5-L19) |
| Opacity | Terminals (and a few apps) are "transparent windows": 0.985 when active, 0.96 when inactive. Other windows are opaque. | [helpers.lua](https://github.com/omacom/omarchy/blob/v4.5.0/default/hypr/helpers.lua#L326-L328), [windows.lua](https://github.com/omacom/omarchy/blob/v4.5.0/default/hypr/windows.lua#L22-L26) |
| Dim inactive windows | off. The user file shows an example with strength 0.15, commented out. | [config looknfeel.lua](https://github.com/omacom/omarchy/blob/v4.5.0/config/hypr/looknfeel.lua#L21-L31) |
| How the focused window is marked | Only by the border color (accent or gradient against grey) and the small opacity step above. No dim, no shadow, no title bar. | rows above |
| Border color animation | `border` animation speed 5.39 with bezier `easeOutQuint` (0.23, 1, 0.32, 1). Hyprland speed is in deciseconds, so 5.39 is 539 ms. | [looknfeel.lua](https://github.com/omacom/omarchy/blob/v4.5.0/default/hypr/looknfeel.lua#L70), [looknfeel.lua](https://github.com/omacom/omarchy/blob/v4.5.0/default/hypr/looknfeel.lua#L77), [Hyprland wiki](https://github.com/hyprwm/hyprland-wiki/blob/ec1068fed41a68d9bace129de16aed785dd785ee/content/configuring/core/animations.md#L16) |
| Window groups (tab bar inside a window) | height 22, monospace 12, active weight `ultraheavy`, indicator 1 px, fill `rgba(00000040)` active and `rgba(00000020)` inactive, text white and `rgba(ffffff90)` | [looknfeel.lua](https://github.com/omacom/omarchy/blob/v4.5.0/default/hypr/looknfeel.lua#L36-L62) |
| 3.8.5: shadow and blur | shadow on (range 2, render power 3, `rgba(1a1a1aee)`), blur on (size 2, passes 2, brightness 0.60, contrast 0.75) | [3.8.5 looknfeel.conf](https://github.com/omacom/omarchy/blob/f4378f0de5b44d331ee943746a97872b718a6c18/default/hypr/looknfeel.conf#L28-L47) |
| 3.8.5: opacity | every window 0.985 active, 0.96 inactive | [3.8.5 windows.conf](https://github.com/omacom/omarchy/blob/f4378f0de5b44d331ee943746a97872b718a6c18/default/hypr/windows.conf#L5-L15) |

### 3.2 Fonts

| Where | Font and size | Source |
|---|---|---|
| Terminal and system | JetBrainsMono Nerd Font for both. The font menu changes the `monospace` alias, so the terminal and the bar change together. | [manual 38](https://github.com/omacom/omarchy/blob/v4.5.0/manual/38-fonts.md#L3-L5) |
| Alacritty | JetBrainsMono Nerd Font, size 9, padding 14 x 14 | [alacritty.toml](https://github.com/omacom/omarchy/blob/v4.5.0/config/alacritty/alacritty.toml#L9-L17) |
| Ghostty | JetBrainsMono Nerd Font, size 9, padding 14 x 14, block cursor, no blink | [ghostty config](https://github.com/omacom/omarchy/blob/v4.5.0/config/ghostty/config#L5-L19) |
| Kitty | JetBrainsMono Nerd Font, size 9.0, padding 14 | [etc/xdg/kitty/kitty.conf](https://github.com/omacom/omarchy/blob/v4.5.0/etc/xdg/kitty/kitty.conf#L4-L9) |
| Foot | JetBrainsMono Nerd Font, size 9, padding 14 x 14 | [foot.ini](https://github.com/omacom/omarchy/blob/v4.5.0/config/foot/foot.ini#L4-L5) |
| Omarchy shell (bar, menus, popups) | family `monospace`, base size 12 px. Scale: caption 10, body-small 11, body 12, subtitle 13, title 14, heading 16, display 24, display-large 28. | [Style.qml](https://github.com/omacom/omarchy/blob/v4.5.0/shell/Commons/Style.qml#L271-L281), [Style.qml](https://github.com/omacom/omarchy/blob/v4.5.0/shell/Commons/Style.qml#L329-L336), [shell.toml.tpl](https://github.com/omacom/omarchy/blob/v4.5.0/default/themed/shell.toml.tpl#L101-L120) |
| 3.8.5 Waybar | JetBrainsMono Nerd Font 12 px | [3.8.5 waybar style.css](https://github.com/omacom/omarchy/blob/f4378f0de5b44d331ee943746a97872b718a6c18/config/waybar/style.css#L3-L12) |
| 3.8.5 Walker (launcher) | monospace 18 px | [3.8.5 walker style.css](https://github.com/omacom/omarchy/blob/f4378f0de5b44d331ee943746a97872b718a6c18/default/walker/themes/omarchy-default/style.css#L7-L10) |
| 3.8.5 Mako (notifications) | sans-serif 14 px | [3.8.5 mako core.ini](https://github.com/omacom/omarchy/blob/f4378f0de5b44d331ee943746a97872b718a6c18/default/mako/core.ini#L9) |
| herdr-omarchy | CaskaydiaMono Nerd Font for terminals and UI. UI text 11 to 13 px, headings up to 16 px. | [RECIPE.md](https://github.com/shafiqimtiaz/herdr-omarchy/blob/2c8c9857601599c3575d1b5e6f2bb48e335d178d/RECIPE.md#L25), [layouts/omarchy.json](https://github.com/shafiqimtiaz/herdr-omarchy/blob/2c8c9857601599c3575d1b5e6f2bb48e335d178d/layouts/omarchy.json#L10-L11) |

### 3.3 Top bar

| Rule | Omarchy 4.5.0 (Omarchy shell) | Omarchy 3.8.5 (Waybar) |
|---|---|---|
| Height | 26 px at font base 12; it grows with the font size ([shell.toml.tpl](https://github.com/omacom/omarchy/blob/v4.5.0/default/themed/shell.toml.tpl#L12-L17)) | 26 px, top layer, top edge, module spacing 0 ([config.jsonc](https://github.com/omacom/omarchy/blob/f4378f0de5b44d331ee943746a97872b718a6c18/config/waybar/config.jsonc#L3-L6)) |
| Background | `background` at alpha 1.0 ([shell.toml.tpl](https://github.com/omacom/omarchy/blob/v4.5.0/default/themed/shell.toml.tpl#L7-L8)). The "Glassy bar" toggle blurs it ([bar-glassy.lua](https://github.com/omacom/omarchy/blob/v4.5.0/default/hypr/toggles/bar-glassy.lua)). | `@background` from the theme, `border-radius: 0`, no border ([style.css](https://github.com/omacom/omarchy/blob/f4378f0de5b44d331ee943746a97872b718a6c18/config/waybar/style.css#L3-L12)). Retro 82 used `alpha(#00172e, 0.8)` ([3.8.5 retro-82/waybar.css](https://github.com/omacom/omarchy/blob/f4378f0de5b44d331ee943746a97872b718a6c18/themes/retro-82/waybar.css)). |
| Text | `foreground`; alerts in `red` ([shell.toml.tpl](https://github.com/omacom/omarchy/blob/v4.5.0/default/themed/shell.toml.tpl#L9-L11)) | `@foreground` |
| Layout | Left: menu logo and workspaces. Center: clock, world clock, weather, update badge. Right: tray, keyboard, agents, bluetooth, network, audio, display, power ([manual 05](https://github.com/omacom/omarchy/blob/v4.5.0/manual/05-the-top-bar.md#L9)). | Left: logo and workspaces. Center: clock, weather, update and indicators. Right: tray, bluetooth, network, audio, CPU, battery ([config.jsonc](https://github.com/omacom/omarchy/blob/f4378f0de5b44d331ee943746a97872b718a6c18/config/waybar/config.jsonc#L7-L15)). |
| Active workspace | The shown workspace has no number. It shows a layout glyph (dwindle, scrolling or floating). Workspaces with no windows are at opacity 0.5. Buttons have 6 px side margins ([Workspaces.qml](https://github.com/omacom/omarchy/blob/v4.5.0/shell/plugins/bar/widgets/Workspaces.qml#L273-L278)). | Same idea: the active workspace shows a glyph; empty buttons have opacity 0.5; padding `0 6px`, margin `0 1.5px` ([style.css](https://github.com/omacom/omarchy/blob/f4378f0de5b44d331ee943746a97872b718a6c18/config/waybar/style.css#L22-L31), [config.jsonc](https://github.com/omacom/omarchy/blob/f4378f0de5b44d331ee943746a97872b718a6c18/config/waybar/config.jsonc#L17-L33)) |

### 3.4 Controls, menus, popups and notifications (Omarchy shell)

From [shell.toml.tpl](https://github.com/omacom/omarchy/blob/v4.5.0/default/themed/shell.toml.tpl) and the defaults in [Style.qml](https://github.com/omacom/omarchy/blob/v4.5.0/shell/Commons/Style.qml#L84-L94):

| State | Fill | Border |
|---|---|---|
| normal | `foreground` at 4 % | 1 px, `foreground` at 40 % |
| hover (mouse or keyboard cursor) | `foreground` at 8 % | 1 px, `foreground` at 25 % |
| focus | same as hover | same as hover |
| selected (current item) | `foreground` at 18 % | none (width 0) |
| pressed | 22 % | (unchanged) |
| text selection | 35 % | none |

| Surface | Background | Border | Other | Source |
|---|---|---|---|---|
| Popups (bar flyouts, OSD) | `background`, alpha 1.0 | the active window border (accent or gradient) | | [L122-L132](https://github.com/omacom/omarchy/blob/v4.5.0/default/themed/shell.toml.tpl#L122-L132) |
| Tooltip | `background`, alpha 0.97 | the active border gradient, foreground variant | | [L134-L141](https://github.com/omacom/omarchy/blob/v4.5.0/default/themed/shell.toml.tpl#L134-L141) |
| Notifications | `background`, alpha 1.0 | the active window border | countdown bar in `accent` | [L143-L152](https://github.com/omacom/omarchy/blob/v4.5.0/default/themed/shell.toml.tpl#L143-L152) |
| Menu | `background`, alpha 1.0; scrim `background` at 50 % | foreground variant of the active border | selected row: `foreground` at 8 %, text in `accent`, border at 25 % | [L172-L187](https://github.com/omacom/omarchy/blob/v4.5.0/default/themed/shell.toml.tpl#L172-L187) |
| Launcher | card at alpha 0.95; scrim 50 % | as menu | as menu | [L154-L170](https://github.com/omacom/omarchy/blob/v4.5.0/default/themed/shell.toml.tpl#L154-L170) |
| Lock input | `background` at 0.8 | active border; error `red` | selection `accent` at 45 % | [L207-L224](https://github.com/omacom/omarchy/blob/v4.5.0/default/themed/shell.toml.tpl#L207-L224) |
| Spacing scale | xxs 2, xs 3, sm 4, md 6, lg 8, xl 10, xxl 12, xxxl 14, huge 18; control height 28; row height 28; panel padding 18 | | | [Style.qml](https://github.com/omacom/omarchy/blob/v4.5.0/shell/Commons/Style.qml#L236-L262) |

3.8.5 values for the same surfaces: Mako notifications were 420 px wide, 20 px from the screen edge, padding 10 x 15, 2 px border in `accent` ([core.ini](https://github.com/omacom/omarchy/blob/f4378f0de5b44d331ee943746a97872b718a6c18/default/mako/core.ini#L1-L9), [mako.ini.tpl](https://github.com/omacom/omarchy/blob/f4378f0de5b44d331ee943746a97872b718a6c18/default/themed/mako.ini.tpl)). The Walker launcher had a 2 px border in `foreground`, padding 20, and a background at alpha 0.95 ([walker style.css](https://github.com/omacom/omarchy/blob/f4378f0de5b44d331ee943746a97872b718a6c18/default/walker/themes/omarchy-default/style.css#L25-L29), [walker.css.tpl](https://github.com/omacom/omarchy/blob/f4378f0de5b44d331ee943746a97872b718a6c18/default/themed/walker.css.tpl)).

One exception to the square rule: btop keeps `rounded_corners = true` ([btop.conf](https://github.com/omacom/omarchy/blob/v4.5.0/config/btop/btop.conf#L28)).

### 3.5 The Herdr copy (herdr-omarchy)

| Rule | Value | Source |
|---|---|---|
| Top bar | 30 px, `chrome` | [RECIPE.md](https://github.com/shafiqimtiaz/herdr-omarchy/blob/2c8c9857601599c3575d1b5e6f2bb48e335d178d/RECIPE.md#L11), [layouts/omarchy.json](https://github.com/shafiqimtiaz/herdr-omarchy/blob/2c8c9857601599c3575d1b5e6f2bb48e335d178d/layouts/omarchy.json#L24-L31) |
| Desk | 10 px padding, 10 px gaps; the wallpaper shows between tiles | [layouts/omarchy.json](https://github.com/shafiqimtiaz/herdr-omarchy/blob/2c8c9857601599c3575d1b5e6f2bb48e335d178d/layouts/omarchy.json#L77-L78) |
| Tiles | `chrome` fill, 2 px `border` (= `muted`) | [RECIPE.md](https://github.com/shafiqimtiaz/herdr-omarchy/blob/2c8c9857601599c3575d1b5e6f2bb48e335d178d/RECIPE.md#L16) |
| Panes | square (`radius: 0`), 2 px `border` frame, 2 px `accent` frame when focused, 10 px gaps, 30 px header | [layouts/omarchy.json](https://github.com/shafiqimtiaz/herdr-omarchy/blob/2c8c9857601599c3575d1b5e6f2bb48e335d178d/layouts/omarchy.json#L179-L195) |
| Zoomed pane | the focus frame grows to 4 px | [wallpaper.js](https://github.com/shafiqimtiaz/herdr-omarchy/blob/2c8c9857601599c3575d1b5e6f2bb48e335d178d/mods/omarchy-bar/wallpaper.js#L25) |
| Terminal padding | 12 x 12 | [layouts/omarchy.json](https://github.com/shafiqimtiaz/herdr-omarchy/blob/2c8c9857601599c3575d1b5e6f2bb48e335d178d/layouts/omarchy.json#L16-L19) |
| Tab strip | a 36 px tile; flat 240 px cells; 1 px `border` dividers; active tab has an 18 % fill and no bottom bar | [RECIPE.md](https://github.com/shafiqimtiaz/herdr-omarchy/blob/2c8c9857601599c3575d1b5e6f2bb48e335d178d/RECIPE.md#L21) |
| Hover | 8 % foreground fill and a 1 px border at 25 % foreground alpha, "after Omarchy's shell control tokens" | [RECIPE.md](https://github.com/shafiqimtiaz/herdr-omarchy/blob/2c8c9857601599c3575d1b5e6f2bb48e335d178d/RECIPE.md#L38) |
| Active space in the bar | number in `foreground` with a 2 px `accent` underline; others in `dim`; blocked spaces in `blocked` | [RECIPE.md](https://github.com/shafiqimtiaz/herdr-omarchy/blob/2c8c9857601599c3575d1b5e6f2bb48e335d178d/RECIPE.md#L12) |
| Sidebar rows | 26 px; active row: 18 % fill and a 2 px `accent` bar on the left | [RECIPE.md](https://github.com/shafiqimtiaz/herdr-omarchy/blob/2c8c9857601599c3575d1b5e6f2bb48e335d178d/RECIPE.md#L17) |

---

## 4. The Omarchy themes

### 4.1 All themes in v4.5.0

The `themes/` folder of tag `v4.5.0` has 23 themes. The manual text says "twenty-two" and shows 19 pictures ([manual 06](https://github.com/omacom/omarchy/blob/v4.5.0/manual/06-themes.md#L3)); last-horizon, lupine, solitude and starship are not in its picture list. Omarchy 3.8.5 had 19 themes, with `osaka-jade`, which v4.5.0 does not have ([3.8.5 themes](https://github.com/omacom/omarchy/blob/f4378f0de5b44d331ee943746a97872b718a6c18/themes)). Mode is the `mode` key.

| Theme | Mode | `background` | `foreground` | `accent` | Source |
|---|---|---|---|---|---|
| catppuccin | dark | `#1e1e2e` | `#cdd6f4` | `#89b4fa` | [colors.toml](https://github.com/omacom/omarchy/blob/v4.5.0/themes/catppuccin/colors.toml) |
| catppuccin-latte | light | `#eff1f5` | `#4c4f69` | `#1e66f5` | [colors.toml](https://github.com/omacom/omarchy/blob/v4.5.0/themes/catppuccin-latte/colors.toml) |
| ethereal | dark | `#060B1E` | `#ffcead` | `#7d82d9` | [colors.toml](https://github.com/omacom/omarchy/blob/v4.5.0/themes/ethereal/colors.toml) |
| everforest | dark | `#2d353b` | `#d3c6aa` | `#7fbbb3` | [colors.toml](https://github.com/omacom/omarchy/blob/v4.5.0/themes/everforest/colors.toml) |
| flexoki-light | light | `#FFFCF0` | `#100F0F` | `#205EA6` | [colors.toml](https://github.com/omacom/omarchy/blob/v4.5.0/themes/flexoki-light/colors.toml) |
| gruvbox | dark | `#282828` | `#d4be98` | `#7daea3` | [colors.toml](https://github.com/omacom/omarchy/blob/v4.5.0/themes/gruvbox/colors.toml) |
| hackerman | dark | `#0B0C16` | `#ddf7ff` | `#82FB9C` | [colors.toml](https://github.com/omacom/omarchy/blob/v4.5.0/themes/hackerman/colors.toml) |
| jade-horse | dark | `#142620` | `#dfede5` | `#8bcbb1` | [colors.toml](https://github.com/omacom/omarchy/blob/v4.5.0/themes/jade-horse/colors.toml) |
| kanagawa | dark | `#1f1f28` | `#dcd7ba` | `#dcd7ba` | [colors.toml](https://github.com/omacom/omarchy/blob/v4.5.0/themes/kanagawa/colors.toml) |
| last-horizon | dark | `#0c0b0c` | `#FAFCFB` | `#b59790` | [colors.toml](https://github.com/omacom/omarchy/blob/v4.5.0/themes/last-horizon/colors.toml) |
| lumon | dark | `#16242d` | `#d6e2ee` | `#8bc9eb` | [colors.toml](https://github.com/omacom/omarchy/blob/v4.5.0/themes/lumon/colors.toml) |
| lupine | light | `#fafafa` | `#212121` | `#3264eb` | [colors.toml](https://github.com/omacom/omarchy/blob/v4.5.0/themes/lupine/colors.toml) |
| matte-black | dark | `#121212` | `#bebebe` | `#e68e0d` | [colors.toml](https://github.com/omacom/omarchy/blob/v4.5.0/themes/matte-black/colors.toml) |
| miasma | dark | `#222222` | `#c2c2b0` | `#78824b` | [colors.toml](https://github.com/omacom/omarchy/blob/v4.5.0/themes/miasma/colors.toml) |
| nord | dark | `#2e3440` | `#d8dee9` | `#81a1c1` | [colors.toml](https://github.com/omacom/omarchy/blob/v4.5.0/themes/nord/colors.toml) |
| retro-82 | dark | `#05182e` | `#f6dcac` | `#faa968` | [colors.toml](https://github.com/omacom/omarchy/blob/v4.5.0/themes/retro-82/colors.toml) |
| ristretto | dark | `#2c2525` | `#e6d9db` | `#f38d70` | [colors.toml](https://github.com/omacom/omarchy/blob/v4.5.0/themes/ristretto/colors.toml) |
| rose-pine | light | `#faf4ed` | `#575279` | `#56949f` | [colors.toml](https://github.com/omacom/omarchy/blob/v4.5.0/themes/rose-pine/colors.toml) |
| solitude | dark | `#101315` | `#cacccc` | `#798186` | [colors.toml](https://github.com/omacom/omarchy/blob/v4.5.0/themes/solitude/colors.toml) |
| starship | dark | `#1c1c1e` | `#f5f5f7` | `#ff9f0a` | [colors.toml](https://github.com/omacom/omarchy/blob/v4.5.0/themes/starship/colors.toml) |
| tokyo-night | dark | `#1a1b26` | `#a9b1d6` | `#7aa2f7` | [colors.toml](https://github.com/omacom/omarchy/blob/v4.5.0/themes/tokyo-night/colors.toml) |
| vantablack | dark | `#000000` | `#ffffff` | `#8d8d8d` | [colors.toml](https://github.com/omacom/omarchy/blob/v4.5.0/themes/vantablack/colors.toml) |
| white | light | `#ffffff` | `#000000` | `#6e6e6e` | [colors.toml](https://github.com/omacom/omarchy/blob/v4.5.0/themes/white/colors.toml) |

### 4.2 The 3 themes closest to synthwave, neon or 80s

My ranking [inference]. Synthwave palettes use hot pink, violet and cyan on a deep blue-violet background. No Omarchy theme has that set.

1. **Retro 82**. The name points at the year 1982 [inference]. Its first wallpaper is `1-in-the-groove.webp`, with an intro video `intros/1-in-the-groove.mp4` ([backgrounds/](https://github.com/omacom/omarchy/blob/v4.5.0/themes/retro-82/backgrounds)). It is a sunset palette: orange `#faa968` and red-orange `#f85525` on navy `#05182e`, with teal. It has no pink and no violet.
2. **Tokyo Night**. Neon city colors on blue-black `#1a1b26`: violet `#bb9af7`, pink-red `#f7768e`, cyan `#0db9d7`. This is the closest hue set to Night Drive, but the accent is blue `#7aa2f7`.
3. **Hackerman**. Neon green `#82FB9C` and cyan on near-black `#0B0C16`, with a green gradient window border. One wallpaper is `1-synth-scape.jpg` ([backgrounds/](https://github.com/omacom/omarchy/blob/v4.5.0/themes/hackerman/backgrounds)). All 6 base colors are green, cyan or blue.

Next candidate: Ethereal (navy `#060B1E`, peach `#ffcead`, periwinkle accent `#7d82d9`).

#### Retro 82

Tokens ([v4.5.0 colors.toml](https://github.com/omacom/omarchy/blob/v4.5.0/themes/retro-82/colors.toml)):

| Token | Value |
|---|---|
| `mode` | `dark` |
| `accent` | `#faa968` |
| `selection` | `#134e5a` |
| `muted` | `#2a6b78` |
| `background` | `#05182e` |
| `dark_background` | `#031222` |
| `darker_background` | `#020c17` |
| `lighter_background` | `#0a2540` |
| `foreground` | `#f6dcac` |
| `dark_foreground` | `#3f8f8a` |
| `light_foreground` | `#a7c9c6` |
| `bright_foreground` | `#f6dcac` |
| `red` | `#f85525` |
| `yellow` | `#e97b3c` |
| `orange` | `#faa968` |
| `green` | `#028391` |
| `cyan` | `#8cbfb8` |
| `blue` | `#3f8f8a` |
| `magenta` | `#3f8f8a` |
| `brown` | `#743d1e` |
| `bright_red` | `#f85525` |
| `bright_yellow` | `#e97b3c` |
| `bright_green` | `#028391` |
| `bright_cyan` | `#8cbfb8` |
| `bright_blue` | `#faa968` |
| `bright_magenta` | `#3f8f8a` |

The 16 ANSI colors. The column "v4.5.0" applies the template rule from section 2 (ANSI 0 = `background`, ANSI 8 = `muted`, ANSI 15 = `bright_foreground`) to the tokens above. The column "3.8.5" is the older explicit palette in [3.8.5 colors.toml](https://github.com/omacom/omarchy/blob/f4378f0de5b44d331ee943746a97872b718a6c18/themes/retro-82/colors.toml).

| ANSI | v4.5.0 token | v4.5.0 value | 3.8.5 value |
|---|---|---|---|
| 0 | `background` | `#05182e` | `#303442` |
| 1 | `red` | `#f85525` | `#f85525` |
| 2 | `green` | `#028391` | `#028391` |
| 3 | `yellow` | `#e97b3c` | `#e97b3c` |
| 4 | `blue` | `#3f8f8a` | `#faa968` |
| 5 | `magenta` | `#3f8f8a` | `#3f8f8a` |
| 6 | `cyan` | `#8cbfb8` | `#8cbfb8` |
| 7 | `foreground` | `#f6dcac` | `#a7c9c6` |
| 8 | `muted` | `#2a6b78` | `#134e5a` |
| 9 | `bright_red` | `#f85525` | `#f85525` |
| 10 | `bright_green` | `#028391` | `#028391` |
| 11 | `bright_yellow` | `#e97b3c` | `#e97b3c` |
| 12 | `bright_blue` | `#faa968` | `#faa968` |
| 13 | `bright_magenta` | `#3f8f8a` | `#3f8f8a` |
| 14 | `bright_cyan` | `#8cbfb8` | `#8cbfb8` |
| 15 | `bright_foreground` | `#f6dcac` | `#f6dcac` |

Other keys in the 3.8.5 file: `accent` = `#faa968`, `active_border_color` = `#faa968`, `active_tab_background` = `#faa968`, `cursor` = `#f6dcac`, `foreground` = `#f6dcac`, `background` = `#05182e`, `selection_foreground` = `#00172e`, `selection_background` = `#faa968`.

Theme overrides: `hyprland.lua` sets the active border to `rgb(faa968)` ([retro-82/hyprland.lua](https://github.com/omacom/omarchy/blob/v4.5.0/themes/retro-82/hyprland.lua)).

#### Tokyo Night

Tokens ([v4.5.0 colors.toml](https://github.com/omacom/omarchy/blob/v4.5.0/themes/tokyo-night/colors.toml)):

| Token | Value |
|---|---|
| `mode` | `dark` |
| `accent` | `#7aa2f7` |
| `selection` | `#292e42` |
| `muted` | `#414868` |
| `background` | `#1a1b26` |
| `dark_background` | `#13141c` |
| `darker_background` | `#0e0e14` |
| `lighter_background` | `#24283b` |
| `foreground` | `#a9b1d6` |
| `dark_foreground` | `#565f89` |
| `light_foreground` | `#b4bee6` |
| `bright_foreground` | `#c0caf5` |
| `red` | `#f7768e` |
| `yellow` | `#e0af68` |
| `orange` | `#eb927b` |
| `green` | `#9ece6a` |
| `cyan` | `#449dab` |
| `blue` | `#7aa2f7` |
| `magenta` | `#ad8ee6` |
| `brown` | `#75493d` |
| `bright_red` | `#ff7a93` |
| `bright_yellow` | `#ff9e64` |
| `bright_green` | `#b9f27c` |
| `bright_cyan` | `#0db9d7` |
| `bright_blue` | `#7da6ff` |
| `bright_magenta` | `#bb9af7` |

The 16 ANSI colors. The column "v4.5.0" applies the template rule from section 2 (ANSI 0 = `background`, ANSI 8 = `muted`, ANSI 15 = `bright_foreground`) to the tokens above. The column "3.8.5" is the older explicit palette in [3.8.5 colors.toml](https://github.com/omacom/omarchy/blob/f4378f0de5b44d331ee943746a97872b718a6c18/themes/tokyo-night/colors.toml).

| ANSI | v4.5.0 token | v4.5.0 value | 3.8.5 value |
|---|---|---|---|
| 0 | `background` | `#1a1b26` | `#32344a` |
| 1 | `red` | `#f7768e` | `#f7768e` |
| 2 | `green` | `#9ece6a` | `#9ece6a` |
| 3 | `yellow` | `#e0af68` | `#e0af68` |
| 4 | `blue` | `#7aa2f7` | `#7aa2f7` |
| 5 | `magenta` | `#ad8ee6` | `#ad8ee6` |
| 6 | `cyan` | `#449dab` | `#449dab` |
| 7 | `foreground` | `#a9b1d6` | `#787c99` |
| 8 | `muted` | `#414868` | `#444b6a` |
| 9 | `bright_red` | `#ff7a93` | `#ff7a93` |
| 10 | `bright_green` | `#b9f27c` | `#b9f27c` |
| 11 | `bright_yellow` | `#ff9e64` | `#ff9e64` |
| 12 | `bright_blue` | `#7da6ff` | `#7da6ff` |
| 13 | `bright_magenta` | `#bb9af7` | `#bb9af7` |
| 14 | `bright_cyan` | `#0db9d7` | `#0db9d7` |
| 15 | `bright_foreground` | `#c0caf5` | `#acb0d0` |

Other keys in the 3.8.5 file: `accent` = `#7aa2f7`, `cursor` = `#c0caf5`, `foreground` = `#a9b1d6`, `background` = `#1a1b26`, `selection_foreground` = `#c0caf5`, `selection_background` = `#7aa2f7`.

Theme extras: `keyboard.rgb` = `ff00ff`; `shell.lock.toml` sets every lock text and border color to `#a9b1d6` ([tokyo-night/shell.lock.toml](https://github.com/omacom/omarchy/blob/v4.5.0/themes/tokyo-night/shell.lock.toml)).

#### Hackerman

Tokens ([v4.5.0 colors.toml](https://github.com/omacom/omarchy/blob/v4.5.0/themes/hackerman/colors.toml)):

| Token | Value |
|---|---|
| `mode` | `dark` |
| `accent` | `#82FB9C` |
| `selection` | `#1f253a` |
| `muted` | `#2d3450` |
| `background` | `#0B0C16` |
| `dark_background` | `#080910` |
| `darker_background` | `#06060c` |
| `lighter_background` | `#151828` |
| `foreground` | `#ddf7ff` |
| `dark_foreground` | `#6a6e95` |
| `light_foreground` | `#b5c5db` |
| `bright_foreground` | `#ddf7ff` |
| `red` | `#50f872` |
| `yellow` | `#50f7d4` |
| `orange` | `#50f7a3` |
| `green` | `#4fe88f` |
| `cyan` | `#7cf8f7` |
| `blue` | `#829dd4` |
| `magenta` | `#86a7df` |
| `brown` | `#287b51` |
| `bright_red` | `#85ff9d` |
| `bright_yellow` | `#a4ffec` |
| `bright_green` | `#9cf7c2` |
| `bright_cyan` | `#d1fffe` |
| `bright_blue` | `#c4d2ed` |
| `bright_magenta` | `#cddbf4` |
| `hyprland_active_border` | `rgba(26a269ee) rgba(2ec27eee) 45deg` |

The 16 ANSI colors. The column "v4.5.0" applies the template rule from section 2 (ANSI 0 = `background`, ANSI 8 = `muted`, ANSI 15 = `bright_foreground`) to the tokens above. The column "3.8.5" is the older explicit palette in [3.8.5 colors.toml](https://github.com/omacom/omarchy/blob/f4378f0de5b44d331ee943746a97872b718a6c18/themes/hackerman/colors.toml).

| ANSI | v4.5.0 token | v4.5.0 value | 3.8.5 value |
|---|---|---|---|
| 0 | `background` | `#0B0C16` | `#3E4058` |
| 1 | `red` | `#50f872` | `#50f872` |
| 2 | `green` | `#4fe88f` | `#4fe88f` |
| 3 | `yellow` | `#50f7d4` | `#50f7d4` |
| 4 | `blue` | `#829dd4` | `#829dd4` |
| 5 | `magenta` | `#86a7df` | `#86a7df` |
| 6 | `cyan` | `#7cf8f7` | `#7cf8f7` |
| 7 | `foreground` | `#ddf7ff` | `#85E1FB` |
| 8 | `muted` | `#2d3450` | `#6a6e95` |
| 9 | `bright_red` | `#85ff9d` | `#85ff9d` |
| 10 | `bright_green` | `#9cf7c2` | `#9cf7c2` |
| 11 | `bright_yellow` | `#a4ffec` | `#a4ffec` |
| 12 | `bright_blue` | `#c4d2ed` | `#c4d2ed` |
| 13 | `bright_magenta` | `#cddbf4` | `#cddbf4` |
| 14 | `bright_cyan` | `#d1fffe` | `#d1fffe` |
| 15 | `bright_foreground` | `#ddf7ff` | `#ddf7ff` |

Other keys in the 3.8.5 file: `accent` = `#82FB9C`, `cursor` = `#ddf7ff`, `foreground` = `#ddf7ff`, `background` = `#0B0C16`, `selection_foreground` = `#0B0C16`, `selection_background` = `#ddf7ff`.

The Herdr renders of Retro 82 and Hackerman in herdr-omarchy have the same 16 values as the "v4.5.0" column ([retro-82.json](https://github.com/shafiqimtiaz/herdr-omarchy/blob/2c8c9857601599c3575d1b5e6f2bb48e335d178d/themes/retro-82.json), [hackerman.json](https://github.com/shafiqimtiaz/herdr-omarchy/blob/2c8c9857601599c3575d1b5e6f2bb48e335d178d/themes/hackerman.json)).

---

## 5. Ideas worth borrowing for Night Drive

Current Night Drive, as read on 2026-11-09: square corners everywhere except spinners, flat 240 px tab cells with 1 px dividers at `--ink` 10 %, tab hover `--ink` 8 %, active tab `--ink` 18 %, a 2 px frame on every pane at `--ink` 12 % and `--accent` on the focused pane, a 1 px composer outline at `--ink` 10 %, a solid accent meter, `--tv-sel` pink at 12 %, and no font, gap, opacity or transition rules ([night-drive.css](../themes/night-drive.css)).

### 5.1 Things a Tern CSS theme can do

| # | Omarchy rule | Night Drive now | Idea |
|---|---|---|---|
| 1 | Shell states: rest 4 % fill + 1 px at 40 %; hover 8 % + 1 px at 25 %; selected 18 %, no border; pressed 22 % ([shell.toml.tpl](https://github.com/omacom/omarchy/blob/v4.5.0/default/themed/shell.toml.tpl#L26-L65)) | Hover 8 % and selected 18 % on tabs: same as Omarchy. No rest fill, no hover border, no pressed state. | Add `[role='tab']:active` at 22 %. Add a 1 px inset border at 25 % on hover. Use the same 4 values on other controls (buttons, rows), so that one rule set covers the whole UI. |
| 2 | Active frame = accent; inactive frame = neutral grey `rgba(595959aa)` ([hyprland.lua.tpl](https://github.com/omacom/omarchy/blob/v4.5.0/default/themed/hyprland.lua.tpl#L1-L2)); herdr-omarchy uses `muted` (= ANSI 8) ([RECIPE.md](https://github.com/shafiqimtiaz/herdr-omarchy/blob/2c8c9857601599c3575d1b5e6f2bb48e335d178d/RECIPE.md#L56)) | Focused `--accent`; others `--ink` at 12 %. Same structure. | Optional: use a solid muted color (`--ansi8` or `--t4`) for the inactive frame, as herdr-omarchy does. |
| 3 | Active border can be a two-color 45-degree gradient (default cyan to green; Hackerman, Last Horizon, Solitude) ([looknfeel.lua](https://github.com/omacom/omarchy/blob/v4.5.0/default/hypr/looknfeel.lua#L3)) | Solid `--accent`. | A `--accent` to `--live` (pink to cyan) 45-degree gradient on `section.tn-pane.on::after` with `border-image`. This is the most Omarchy-like way to add synthwave color without glow. |
| 4 | Border color animates in 539 ms, `easeOutQuint` ([looknfeel.lua](https://github.com/omacom/omarchy/blob/v4.5.0/default/hypr/looknfeel.lua#L77), [Hyprland wiki](https://github.com/hyprwm/hyprland-wiki/blob/ec1068fed41a68d9bace129de16aed785dd785ee/content/configuring/core/animations.md#L16)) | No transition. | `transition: border-color 539ms cubic-bezier(0.23, 1, 0.32, 1)` on the pane frame. A gradient `border-image` cannot animate this way [inference], so choose idea 3 or idea 4. |
| 5 | Gaps 5 px inner, 10 px outer; herdr-omarchy 10 px everywhere ([looknfeel.lua](https://github.com/omacom/omarchy/blob/v4.5.0/default/hypr/looknfeel.lua#L8-L9), [layouts/omarchy.json](https://github.com/shafiqimtiaz/herdr-omarchy/blob/2c8c9857601599c3575d1b5e6f2bb48e335d178d/layouts/omarchy.json#L77-L78)) | No gaps. | Space between panes, with `--page` showing through. Whether Tern CSS can add gaps without a layout break is [unconfirmed]. Test first. |
| 6 | Inactive terminals at 0.96 opacity, active at 0.985 ([helpers.lua](https://github.com/omacom/omarchy/blob/v4.5.0/default/hypr/helpers.lua#L326-L328)) | No opacity rule. | `section.tn-pane:not(.on)` at a slightly lower opacity. The effect on Tern terminal rendering is [unconfirmed]. |
| 7 | Square corners, the default design ([manual 42](https://github.com/omacom/omarchy/blob/v4.5.0/manual/42-common-tweaks.md#L13)) | Done (`border-radius: 0`, `--r-*: 0px`); spinners stay round. | Nothing to add. |
| 8 | Terminal rule: ANSI 0 = background, ANSI 7 = foreground, ANSI 8 = muted, ANSI 15 = bright foreground ([ghostty.conf.tpl](https://github.com/omacom/omarchy/blob/v4.5.0/default/themed/ghostty.conf.tpl)) | `--ansi0` `#272036` is not `--tv-bg` `#1c1629`; `--ansi7` `#e0d5f0` is not `--tv-fg` `#ece6f5`. | Keep the distinct `--ansi0`. With ANSI 0 = background, black text is invisible. The Omarchy 3.8.5 palettes also used a distinct `color0` (Tokyo Night `#32344a` on `#1a1b26`, [3.8.5 colors.toml](https://github.com/omacom/omarchy/blob/f4378f0de5b44d331ee943746a97872b718a6c18/themes/tokyo-night/colors.toml)). |
| 9 | Cursor = `bright_foreground`, cursor text = `background` ([kitty.conf.tpl](https://github.com/omacom/omarchy/blob/v4.5.0/default/themed/kitty.conf.tpl)) | Cursor `--accent` pink, cursor ink `--tv-bg`. | Keep the pink cursor (it is a Night Drive mark). The cursor ink rule is the same. |
| 10 | Chrome color = background mixed 25 % with black (`dark_background`); brights = base mixed 20 % with white ([omarchy-theme-color](https://github.com/omacom/omarchy/blob/v4.5.0/bin/omarchy-theme-color#L236-L243)) | `--page` `#140f1f` is darker than `--tv-bg` `#1c1629`. The 25 % rule applied to `--tv-bg` gives a value within 2 steps per channel of `--page` [computed by me]. The Night Drive brights are lighter than the 20 % rule [computed by me]. | Use the two rules as a check when a color changes, so that `--page` and the brights move with the base colors. |
| 11 | Popups and notifications: 2 px border in the active border color; menus: scrim `background` at 50 %, selected row at 8 % with `accent` text ([shell.toml.tpl](https://github.com/omacom/omarchy/blob/v4.5.0/default/themed/shell.toml.tpl#L122-L187)) | No rules for menus or dialogs. | Style Tern menus and dialogs the same way, if Tern exposes selectors for them [unconfirmed]. |
| 12 | One monospace font for terminal and UI; terminal size 9 with 14 px padding; UI base 12 px with a 10/11/12/13/14/16 scale ([manual 38](https://github.com/omacom/omarchy/blob/v4.5.0/manual/38-fonts.md#L3), [Style.qml](https://github.com/omacom/omarchy/blob/v4.5.0/shell/Commons/Style.qml#L329-L336)) | No font rules. | Set the UI font to the terminal font (JetBrainsMono Nerd Font or CaskaydiaMono Nerd Font) and use the 10 to 16 px scale. Whether a Tern theme can set the terminal font or padding is [unconfirmed]. |
| 13 | Bar 26 px (Omarchy), 30 px top bar and 36 px tab tile (herdr-omarchy) ([shell.toml.tpl](https://github.com/omacom/omarchy/blob/v4.5.0/default/themed/shell.toml.tpl#L16), [layouts/omarchy.json](https://github.com/shafiqimtiaz/herdr-omarchy/blob/2c8c9857601599c3575d1b5e6f2bb48e335d178d/layouts/omarchy.json#L27), [layouts/omarchy.json](https://github.com/shafiqimtiaz/herdr-omarchy/blob/2c8c9857601599c3575d1b5e6f2bb48e335d178d/layouts/omarchy.json#L154)) | Tabs fill the height of `#tabbar`; no height rule. | Set `#tabbar` to a fixed height if Tern allows it [unconfirmed]. |
| 14 | Selection: a solid token color (Tokyo Night `#292e42`, Retro 82 `#134e5a`) ([tokyo-night/colors.toml](https://github.com/omacom/omarchy/blob/v4.5.0/themes/tokyo-night/colors.toml)) | Pink at 12 % alpha. | No change needed. The earlier research ([retro-themes.md](retro-themes.md)) recommends a low-alpha selection. |
| 15 | Zoomed pane: the focus frame grows from 2 px to 4 px ([wallpaper.js](https://github.com/shafiqimtiaz/herdr-omarchy/blob/2c8c9857601599c3575d1b5e6f2bb48e335d178d/mods/omarchy-bar/wallpaper.js#L25)) | No zoom rule. | A 4 px frame on a zoomed pane, if Tern marks a zoomed pane with a class or attribute [unconfirmed]. |

### 5.2 Things that only a Tern plugin could do

The Tern plugin API is not part of this research. Every row here is [unconfirmed] for Tern.

| # | Omarchy or herdr-omarchy feature | Night Drive now | Why CSS is not enough |
|---|---|---|---|
| 1 | Theme switcher with big desktop previews, left and right to choose ([RECIPE.md](https://github.com/shafiqimtiaz/herdr-omarchy/blob/2c8c9857601599c3575d1b5e6f2bb48e335d178d/RECIPE.md#L47), [manual 06](https://github.com/omacom/omarchy/blob/v4.5.0/manual/06-themes.md#L3)) | none | Needs a dialog, input and a theme change command. |
| 2 | Wallpaper per theme, visible between tiles; `Super + Ctrl + W` cycles it ([manual 06](https://github.com/omacom/omarchy/blob/v4.5.0/manual/06-themes.md#L7), [layouts/omarchy.json](https://github.com/shafiqimtiaz/herdr-omarchy/blob/2c8c9857601599c3575d1b5e6f2bb48e335d178d/layouts/omarchy.json#L12-L15)) | none | Cycling needs state. A fixed background image through CSS could work if Tern loads `url()` in themes [unconfirmed]. |
| 3 | One palette file that makes every config, with `_strip`, `_rgb` and `mix` ([omarchy-theme-set-templates](https://github.com/omacom/omarchy/blob/v4.5.0/bin/omarchy-theme-set-templates#L162-L198)) | Night Drive repeats raw hex values in many variables. | A build script could make `night-drive.css` from one palette file, and could also export an Omarchy `colors.toml`. This is a tool, not a CSS rule. |
| 4 | Light or dark pairing from one `mode` key ([manual 43](https://github.com/omacom/omarchy/blob/v4.5.0/manual/43-making-your-own-theme.md#L19-L21)) | Dark only (`color-scheme: dark`). | Needs a second palette and a switch. |
| 5 | Top bar with space numbers, an underlined active space and agent status colors ([RECIPE.md](https://github.com/shafiqimtiaz/herdr-omarchy/blob/2c8c9857601599c3575d1b5e6f2bb48e335d178d/RECIPE.md#L11-L12)) | none | Needs data about spaces and agents. |
| 6 | Bar alert color (`red`) on modules that need attention ([shell.toml.tpl](https://github.com/omacom/omarchy/blob/v4.5.0/default/themed/shell.toml.tpl#L10-L11)) | none | Needs a state flag on the element, unless Tern already sets one [unconfirmed]. |
| 7 | Layout glyph in place of the active workspace number ([Workspaces.qml](https://github.com/omacom/omarchy/blob/v4.5.0/shell/plugins/bar/widgets/Workspaces.qml#L273)) | none | Needs layout state. |

---

## Sources

Omarchy, tag `v4.5.0` (commit `ac2690c`), [github.com/omacom/omarchy](https://github.com/omacom/omarchy/blob/v4.5.0/README.md):

- Manual: [05 The top bar](https://github.com/omacom/omarchy/blob/v4.5.0/manual/05-the-top-bar.md), [06 Themes](https://github.com/omacom/omarchy/blob/v4.5.0/manual/06-themes.md), [38 Fonts](https://github.com/omacom/omarchy/blob/v4.5.0/manual/38-fonts.md), [42 Common tweaks](https://github.com/omacom/omarchy/blob/v4.5.0/manual/42-common-tweaks.md), [43 Making your own theme](https://github.com/omacom/omarchy/blob/v4.5.0/manual/43-making-your-own-theme.md)
- Theme scripts: [bin/omarchy-theme-set](https://github.com/omacom/omarchy/blob/v4.5.0/bin/omarchy-theme-set), [bin/omarchy-theme-set-templates](https://github.com/omacom/omarchy/blob/v4.5.0/bin/omarchy-theme-set-templates), [bin/omarchy-theme-color](https://github.com/omacom/omarchy/blob/v4.5.0/bin/omarchy-theme-color), [config/omarchy/themed/alacritty.toml.tpl.sample](https://github.com/omacom/omarchy/blob/v4.5.0/config/omarchy/themed/alacritty.toml.tpl.sample)
- Templates: [default/themed/](https://github.com/omacom/omarchy/blob/v4.5.0/default/themed), in particular [hyprland.lua.tpl](https://github.com/omacom/omarchy/blob/v4.5.0/default/themed/hyprland.lua.tpl), [shell.toml.tpl](https://github.com/omacom/omarchy/blob/v4.5.0/default/themed/shell.toml.tpl), [ghostty.conf.tpl](https://github.com/omacom/omarchy/blob/v4.5.0/default/themed/ghostty.conf.tpl), [kitty.conf.tpl](https://github.com/omacom/omarchy/blob/v4.5.0/default/themed/kitty.conf.tpl), [btop.theme.tpl](https://github.com/omacom/omarchy/blob/v4.5.0/default/themed/btop.theme.tpl), [neovim.lua.tpl](https://github.com/omacom/omarchy/blob/v4.5.0/default/themed/neovim.lua.tpl)
- Hyprland: [default/hypr/looknfeel.lua](https://github.com/omacom/omarchy/blob/v4.5.0/default/hypr/looknfeel.lua), [config/hypr/looknfeel.lua](https://github.com/omacom/omarchy/blob/v4.5.0/config/hypr/looknfeel.lua), [default/hypr/helpers.lua](https://github.com/omacom/omarchy/blob/v4.5.0/default/hypr/helpers.lua), [default/hypr/windows.lua](https://github.com/omacom/omarchy/blob/v4.5.0/default/hypr/windows.lua), [default/hypr/glass.lua](https://github.com/omacom/omarchy/blob/v4.5.0/default/hypr/glass.lua), [default/hypr/toggles/](https://github.com/omacom/omarchy/blob/v4.5.0/default/hypr/toggles)
- Shell: [shell/Commons/Style.qml](https://github.com/omacom/omarchy/blob/v4.5.0/shell/Commons/Style.qml), [shell/plugins/bar/widgets/Workspaces.qml](https://github.com/omacom/omarchy/blob/v4.5.0/shell/plugins/bar/widgets/Workspaces.qml)
- Terminals and btop: [config/alacritty/alacritty.toml](https://github.com/omacom/omarchy/blob/v4.5.0/config/alacritty/alacritty.toml), [config/ghostty/config](https://github.com/omacom/omarchy/blob/v4.5.0/config/ghostty/config), [etc/xdg/kitty/kitty.conf](https://github.com/omacom/omarchy/blob/v4.5.0/etc/xdg/kitty/kitty.conf), [config/foot/foot.ini](https://github.com/omacom/omarchy/blob/v4.5.0/config/foot/foot.ini), [config/btop/btop.conf](https://github.com/omacom/omarchy/blob/v4.5.0/config/btop/btop.conf)
- Themes: [themes/](https://github.com/omacom/omarchy/blob/v4.5.0/themes) (all 23 `colors.toml` files, and the `hyprland.lua`, `shell.lock.toml`, `neovim.lua`, `vscode.json` files linked above)

Omarchy, branch `quattro` at commit `b99593e`: [default/themed/herdr-app.json.tpl](https://github.com/omacom/omarchy/blob/b99593ed3c5d104210394669efc88a684f76ddbf/default/themed/herdr-app.json.tpl), [bin/omarchy-theme-set-herdr-app](https://github.com/omacom/omarchy/blob/b99593ed3c5d104210394669efc88a684f76ddbf/bin/omarchy-theme-set-herdr-app), added in commit [4907fcd](https://github.com/omacom/omarchy/commit/4907fcdf74eb5d3de6b33a02a9e3c972624f5881).

Omarchy 3.8.5, branch `master` at commit `f4378f0`: [default/hypr/looknfeel.conf](https://github.com/omacom/omarchy/blob/f4378f0de5b44d331ee943746a97872b718a6c18/default/hypr/looknfeel.conf), [default/hypr/windows.conf](https://github.com/omacom/omarchy/blob/f4378f0de5b44d331ee943746a97872b718a6c18/default/hypr/windows.conf), [config/waybar/config.jsonc](https://github.com/omacom/omarchy/blob/f4378f0de5b44d331ee943746a97872b718a6c18/config/waybar/config.jsonc), [config/waybar/style.css](https://github.com/omacom/omarchy/blob/f4378f0de5b44d331ee943746a97872b718a6c18/config/waybar/style.css), [default/mako/core.ini](https://github.com/omacom/omarchy/blob/f4378f0de5b44d331ee943746a97872b718a6c18/default/mako/core.ini), [default/themed/mako.ini.tpl](https://github.com/omacom/omarchy/blob/f4378f0de5b44d331ee943746a97872b718a6c18/default/themed/mako.ini.tpl), [default/walker/themes/omarchy-default/style.css](https://github.com/omacom/omarchy/blob/f4378f0de5b44d331ee943746a97872b718a6c18/default/walker/themes/omarchy-default/style.css), [default/themed/walker.css.tpl](https://github.com/omacom/omarchy/blob/f4378f0de5b44d331ee943746a97872b718a6c18/default/themed/walker.css.tpl), [themes/](https://github.com/omacom/omarchy/blob/f4378f0de5b44d331ee943746a97872b718a6c18/themes) (`colors.toml` with `color0` to `color15`, `retro-82/waybar.css`).

herdr-omarchy, commit `2c8c985`, [github.com/shafiqimtiaz/herdr-omarchy](https://github.com/shafiqimtiaz/herdr-omarchy/blob/2c8c9857601599c3575d1b5e6f2bb48e335d178d/README.md): [RECIPE.md](https://github.com/shafiqimtiaz/herdr-omarchy/blob/2c8c9857601599c3575d1b5e6f2bb48e335d178d/RECIPE.md), [layouts/omarchy.json](https://github.com/shafiqimtiaz/herdr-omarchy/blob/2c8c9857601599c3575d1b5e6f2bb48e335d178d/layouts/omarchy.json), [themes/](https://github.com/shafiqimtiaz/herdr-omarchy/blob/2c8c9857601599c3575d1b5e6f2bb48e335d178d/themes) (23 JSON files), [mods/omarchy-bar/wallpaper.js](https://github.com/shafiqimtiaz/herdr-omarchy/blob/2c8c9857601599c3575d1b5e6f2bb48e335d178d/mods/omarchy-bar/wallpaper.js).

Herdr app, commit `b721ded`: [defaults/AGENTS.md](https://github.com/herdrdev/herdr-app/blob/b721deda985270ec8256552692729a4add389b2a/defaults/AGENTS.md) (theme file format and theme color names), [defaults/themes/win98.json](https://github.com/herdrdev/herdr-app/blob/b721deda985270ec8256552692729a4add389b2a/defaults/themes/win98.json).

Hyprland wiki, commit `ec1068f`: [animations.md](https://github.com/hyprwm/hyprland-wiki/blob/ec1068fed41a68d9bace129de16aed785dd785ee/content/configuring/core/animations.md) (animation speed unit).

Night Drive: [themes/night-drive.css](../themes/night-drive.css), read on 2026-11-09.
