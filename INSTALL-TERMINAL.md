# Dr.C Terminal — Install Guide

Dr.C Terminal is a full-featured TUI (terminal UI) for AI-assisted Csound development. It runs in any terminal on macOS, Linux, or Windows and is built with [Bun](https://bun.sh).

**Source:** [github.com/mateolarreaferro/Dr.C](https://github.com/mateolarreaferro/Dr.C)

---

## Requirements

| Tool | Version | Notes |
|---|---|---|
| [Bun](https://bun.sh) | 1.3.9 or later | JavaScript runtime + package manager |
| [Csound](https://csound.com/download.html) | 6.18+ or 7.x | Must be on your `PATH` |
| AI API key | — | Gemini (free), Anthropic, or OpenAI |
| Git | any | For cloning the repo |

---

## 1 — Install Csound

### macOS
```bash
brew install csound
```

### Linux (Debian / Ubuntu)
```bash
sudo apt update && sudo apt install -y csound build-essential python3 unzip
```
> `build-essential`, `python3`, and `unzip` are all required on Ubuntu 22.04 — install them in the same step as Csound.

### Linux (Fedora / RHEL)
```bash
sudo dnf install csound
```

### Linux (Arch / Manjaro)
```bash
sudo pacman -S csound
```

### Windows
Download and run the installer from [csound.com/download](https://csound.com/download.html).  
During install, check **"Add csound to PATH"**.

**Verify:**
```bash
csound --version
```

---

## 1.5 — Install CsoundQt 7 (optional, recommended)

CsoundQt is the Csound IDE for deeper editing, manual lookup, and comparing with Dr.C output. For Csound 7 workflows, use **CsoundQt v7.x** (beta), not the older Csound 6 builds.

**Releases:** [github.com/CsoundQt/CsoundQt/releases](https://github.com/CsoundQt/CsoundQt/releases) — **v7.0.0-beta3** or newer.

### macOS

1. Install Csound 7 (§1).
2. Download the v7 **MacOS.dmg**, drag CsoundQt into **Applications**.
3. In Dr.C: CSD panel toolbar → **csoundqt**, or command palette → **Open in CsoundQt**.

### Linux

1. Install Csound 7 first.
2. Prefer the v7 **AppImage** from GitHub if your package manager only has Csound 6-era builds:
   ```bash
   chmod +x CsoundQt-*-AppImage && ./CsoundQt-*-AppImage
   ```
3. Or: `sudo apt install csoundqt` where available.

### Windows

1. Install Csound 7; note `C:\Program Files\Csound7_x64\bin` (path may vary).
2. Unzip the v7 **Win64.zip** from GitHub.
3. Copy Csound 7 `bin` contents into the CsoundQt `bin` folder.
4. Run `CsoundQt.exe`. Dr.C detects it automatically when on PATH or under Program Files.

**In Dr.C Terminal:** CSD panel → **web** | **cabbage** | **csoundqt** | **play**.

---

## 1.6 — Install Cabbage (optional, recommended)

Cabbage builds live MIDI plugin UIs from Csound. Optional but recommended for workshop VST workflows.

**Downloads:** [cabbageaudio.com/download](https://cabbageaudio.com/download/) · [GitHub releases](https://github.com/cabbageaudio/Cabbage/releases)

### macOS

1. Download the macOS DMG → drag **Cabbage** into **Applications**.
2. Dr.C: **Settings → Cabbage** or command palette → **Open in Cabbage**.

### Linux

1. AppImage or package from cabbageaudio.com — verify **aarch64** vs x86_64 for your machine.
2. `chmod +x Cabbage-*-AppImage && ./Cabbage-*-AppImage`
3. Dr.C auto-detects `cabbage` on PATH; set path in settings if needed.

---

## 1.7 — Install Audacity (optional, recommended)

Listen to and edit Dr.C WAV exports.

### macOS

```bash
brew install --cask audacity
```

Or [audacityteam.org/download](https://www.audacityteam.org/download/).

### Linux (Ubuntu 22.04)

```bash
sudo apt install audacity
```

Or Flatpak: `flatpak install flathub org.audacityteam.Audacity`

---

## 1.8 — Install Reaper (optional, recommended)

Lightweight DAW host for Cabbage exports and multitrack demos.

**Download:** [reaper.fm/download.php](https://www.reaper.fm/download.php)

### macOS

1. Download **ARM64** (Apple Silicon) or **x86_64** (Intel) from reaper.fm.
2. Drag **REAPER.app** to **Applications**; accept eval license on first launch.
3. Or: `brew install --cask reaper`

### Linux

1. Download **aarch64** or **x86_64** Linux tarball from reaper.fm.
2. Run `install-reaper.sh` or unpack to `~/opt/REAPER`.
3. Eval license — no time limit; full license optional.

---

## 2 — Install Bun

### macOS / Linux
```bash
curl -fsSL https://bun.sh/install | bash
```

Restart your terminal after this, or run `source ~/.bashrc` (or `~/.zshrc`).

### Windows
```powershell
powershell -c "irm bun.sh/install.ps1 | iex"
```

Or install via npm if you already have Node.js:
```bash
npm install -g bun
```

**Verify:**
```bash
bun --version
# should print 1.3.9 or later
```

---

## 3 — Clone and Install

```bash
git clone https://github.com/mateolarreaferro/Dr.C.git
cd Dr.C/opencode
bun install
```
> **Important:** `bun install` must be run from the `opencode/` subdirectory, not the repo root.

`bun install` downloads all dependencies. It is fast (usually under 30 seconds).

---

## 4 — Get an API Key (before first run)

Dr.C defaults to **Gemini 2.5 Flash**, which is free with a Google AI Studio key.

1. Go to [aistudio.google.com/apikey](https://aistudio.google.com/apikey)
2. Sign in with a Google account → **Create API Key**
3. Copy the key — you will paste it in the next step

> The key must be an **AI Studio** key from `aistudio.google.com` — NOT a Vertex AI service account.

---

## 5 — Add Your API Key

Dr.C stores keys in its own credential store. Run the auth command once:

```bash
cd Dr.C/opencode && bun run dev -- auth login
```

Select **Google** from the provider list and paste your Gemini API key when prompted. The key is saved permanently — you won't need to do this again.

---

## 6 — Run

```bash
cd Dr.C/opencode && bun run dev
```

This launches `drc`, the Dr.C TUI. You will see the welcome screen with Quick Start suggestions. Type any prompt to begin — for example: `make a simple FM synthesizer`.

### Settings in the TUI

Open the command palette (`Ctrl+P` or `/`) and choose **Dr.C settings**, or type **`/settings`**.

From there you can:

- See which API providers are connected (Gemini, Groq, Anthropic, OpenAI, Ollama)
- Connect providers or run `drc auth login` from the terminal
- Read free-tier rate-limit notes
- Enable **Ollama** (local model, no API key) — install from [ollama.com](https://ollama.com/download), then `ollama pull qwen2.5-coder:7b`
- Set **CsoundQt** and **Cabbage** paths for **csoundqt** / **cabbage** buttons on the CSD panel

Settings are saved to `~/.config/drc/drc.json` under the `workshop` section.

---

## Linux Audio Notes

Dr.C shells out to `csound` for compile/render/play. Csound on Linux defaults to **ALSA**. If you use **JACK**, either:

- Start JACK before running Dr.C, or
- Set the Csound output device in your CSD's `<CsOptions>`:  
  ```
  -+rtaudio=jack -odac
  ```

Dr.C's render workflow writes WAV files to a session temp directory (`~/.drc/sessions/`), so audio playback only needs a working audio device for the "play" step. Compilation and export work without any audio device.

### Common Linux package names

| Distro | Csound package | Build tools (if needed) |
|---|---|---|
| Debian/Ubuntu | `csound` | `build-essential` |
| Fedora | `csound` | `gcc gcc-c++ make` |
| Arch | `csound` | `base-devel` |
| openSUSE | `csound` | `gcc-c++ make` |

---

## Windows Notes

- Use **Git Bash**, **WSL2**, or **PowerShell** — all work with Bun.
- The `csound` CLI must be on your Windows `PATH`. Open a new terminal after installing Csound and verify with `csound --version`.
- WSL2 users: install Csound inside WSL (`sudo apt install csound`) for the smoothest experience.

---

## Troubleshooting

**`bun: command not found`**  
Close and reopen your terminal, or add `~/.bun/bin` to your `PATH`:
```bash
export PATH="$HOME/.bun/bin:$PATH"
```

**`csound: command not found`**  
Csound is not on your PATH. On macOS with Homebrew, run `brew link csound`. On Linux, verify the package installed correctly with `which csound`.

**`Error: GEMINI_API_KEY not set`**  
Make sure `.env` exists at the repo root (not `.env.example`) and contains your key.

**Audio plays but sounds wrong / silent**  
Check that your system audio is not muted and that Csound has permission to access the audio device. On some Linux systems you may need to add your user to the `audio` group:
```bash
sudo usermod -aG audio $USER
# log out and back in
```

---

## Operating Modes

Once running, Dr.C has two main modes selectable via the mode toggle:

- **Complex mode** — full agent, RAG retrieval, alternatives workflow, sub-agents. Use this for synthesis design and creative work.
- **Sine mode** — lightweight fast-edit agent (Haiku model). Use this for quick parameter tweaks and bug fixes.

Type anything to start — for example:  
`make a granular texture synth with slow, evolving grain clouds`

---

← [Back to workshop README](./README.md) | [Standalone install →](./INSTALL-STANDALONE.md)
