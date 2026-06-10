# Dr.C Standalone — Install Guide

Dr.C Standalone is the graphical Electron desktop application for AI-assisted Csound development. It features a dual-panel chat + code editor, design tree navigation, and live artifact preview.

**Source:** [github.com/csounder/drc-standalone](https://github.com/csounder/drc-standalone)

---

## Requirements

| Tool | Version | Notes |
|---|---|---|
| [Node.js](https://nodejs.org) | 20 or later (LTS) | npm is included |
| [Csound](https://csound.com/download.html) | 6.18+ or 7.x | Must be on your `PATH` |
| AI API key | — | Gemini (free), Anthropic, or OpenAI |
| Git | any | For cloning the repo |

---

## 1 — Install Node.js (v20 LTS or later)

### macOS
```bash
brew install node
```
Or download the LTS installer from [nodejs.org](https://nodejs.org).

### Linux — using NodeSource (recommended, gets you v20 LTS)

**Debian / Ubuntu:**
```bash
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt install -y nodejs
```

**Fedora / RHEL:**
```bash
curl -fsSL https://rpm.nodesource.com/setup_20.x | sudo bash -
sudo dnf install -y nodejs
```

**Arch / Manjaro:**
```bash
sudo pacman -S nodejs npm
```

**openSUSE:**
```bash
sudo zypper install nodejs20
```

### Linux — using nvm (works on any distro)
```bash
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
# restart terminal, then:
nvm install 20
nvm use 20
```

### Windows
Download and run the LTS installer from [nodejs.org](https://nodejs.org/en/download).  
npm is included — no separate install needed.

**Verify:**
```bash
node --version   # should be v20.x or higher
npm --version
```

---

## 2 — Install Csound

### macOS
```bash
brew install csound
```

### Linux (Debian / Ubuntu)
```bash
sudo apt update && sudo apt install csound
```

### Linux (Fedora / RHEL)
```bash
sudo dnf install csound
```

### Linux (Arch / Manjaro)
```bash
sudo pacman -S csound
```

### Linux — extra build tools (needed on some distros)

`better-sqlite3` (used for session memory) is a native Node module and compiles during `npm install`. If it fails, install build tools first:

**Debian / Ubuntu:**
```bash
sudo apt install build-essential python3
```

**Fedora:**
```bash
sudo dnf groupinstall "Development Tools"
sudo dnf install python3
```

**Arch:**
```bash
sudo pacman -S base-devel python
```

### Windows
Download and run the installer from [csound.com/download](https://csound.com/download.html).  
During install, check **"Add csound to PATH"**.

**Verify:**
```bash
csound --version
```

---

## 3 — Clone and Install

```bash
git clone https://github.com/csounder/drc-standalone.git
cd drc-standalone
npm install
```

`npm install` also compiles the native `better-sqlite3` module. On Linux this requires the build tools above. It typically takes 1–3 minutes.

---

## 4 — Add Your API Key

**Option A — via `.env` file (recommended for dev):**

```bash
cp .env.example .env
```

Open `.env` and fill in at least one key:

```
# Gemini 2.5 Flash — free from https://aistudio.google.com/apikey
GEMINI_API_KEY=your_key_here

# Optional fallbacks
ANTHROPIC_API_KEY=
OPENAI_API_KEY=
```

**Option B — via the Settings page:**  
Launch the app (`npm run dev`), click the ⚙️ Settings icon, paste your key, and click **Test**. The key is saved locally.

> The Gemini key must be an **AI Studio** key from `aistudio.google.com` — NOT a Vertex AI service account.

---

## 5 — Run

```bash
npm run dev
```

This bundles the app and opens the Electron window. Hot reload is active — changes to source files reload automatically.

---

## macOS First Launch Warning

The app is not code-signed. macOS Gatekeeper will say it is "damaged" or "cannot be opened." Fix it with one of:

- Right-click the app → **Open** → **Open**
- Or run once in terminal:
  ```bash
  xattr -cr /Applications/DrC.app
  ```

---

## Linux Notes

### Audio

Dr.C shells out to `csound` for compile/render/play. Csound on Linux defaults to **ALSA**. If you use **JACK**:

- Start JACK before launching Dr.C, or
- Set the audio backend in your CSD's `<CsOptions>`:
  ```
  -+rtaudio=jack -odac
  ```

Compilation and web export work without any audio device — only playback requires one.

### Electron on Linux

The Electron window requires a display server. On a headless or Wayland-only machine, you may need:

```bash
# Wayland
export ELECTRON_OZONE_PLATFORM_HINT=wayland
npm run dev

# or force X11 mode
npm run dev -- --no-sandbox
```

On some minimal Linux installs, Electron needs additional shared libraries. If the window fails to open, install:

```bash
# Debian/Ubuntu
sudo apt install libnss3 libatk-bridge2.0-0 libgtk-3-0 libxss1 libasound2

# Fedora
sudo dnf install nss atk at-spi2-atk gtk3 libXScrnSaver alsa-lib
```

### Common Linux package names

| Distro | Csound | Build tools |
|---|---|---|
| Debian/Ubuntu | `csound` | `build-essential python3` |
| Fedora | `csound` | `gcc gcc-c++ make python3` |
| Arch | `csound` | `base-devel python` |
| openSUSE | `csound` | `gcc-c++ make python3` |

---

## Windows Notes

- Node.js 20 LTS from nodejs.org includes everything you need.
- `npm install` on Windows may need **windows-build-tools** if `better-sqlite3` compilation fails:
  ```powershell
  npm install --global windows-build-tools
  ```
  Or install [Visual Studio Build Tools](https://visualstudio.microsoft.com/visual-cpp-build-tools/) with the "Desktop development with C++" workload.
- The `csound` CLI must be on your PATH — open a new terminal after installing and verify with `csound --version`.

---

## Troubleshooting

**`npm install` fails on `better-sqlite3`**  
Install build tools (see Linux Notes or Windows Notes above), then retry:
```bash
npm install
```

**`csound: command not found`**  
Csound is not on your PATH. On macOS with Homebrew: `brew link csound`. On Linux, check `which csound` and make sure the package installed correctly.

**Electron window is blank / doesn't open**  
On Linux, try the `--no-sandbox` flag or install missing Electron system libraries (see Linux Notes above).

**`GEMINI_API_KEY not set` error**  
Make sure `.env` exists at the repo root (not just `.env.example`) and contains your key with no extra spaces.

**App opens but AI doesn't respond**  
Check that your API key is valid. In the Settings page, use the **Test** button to verify the key. Also confirm you have internet access — Dr.C calls the LLM API on every message.

---

## What the App Does at a Glance

- **Chat panel** — describe what you want in plain English or Csound vocabulary
- **Code panel** — generated CSD appears here, editable at any time
- **Design tree** — non-linear version history of all explored alternatives
- **Signal flow diagram** — auto-generated ASCII diagram explaining the synthesis chain
- **Web export** — one command produces a self-contained HTML file using `@csound/browser`

---

← [Back to workshop README](./README.md) | [Terminal install →](./INSTALL-TERMINAL.md)
