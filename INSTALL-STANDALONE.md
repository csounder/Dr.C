# Dr.C Standalone — Install Guide (Csound 7 Workshop Build)

Dr.C Standalone is the graphical Electron app for AI-assisted Csound development: chat + code editor, design tree, web synth export, and educational narration.

**Source (build from here — do not use the old v1.3.0 .app alone):**  
[github.com/mateolarreaferro/Dr.C-Standalone](https://github.com/mateolarreaferro/Dr.C-Standalone)

> **Csound 7 required.** The v1.3.1+ workshop build targets Csound 7 for CLI render and `@csound/browser` 7 for web apps. Csound 6.18 on PATH causes poor first-shot codegen.

---

## Requirements

| Tool | Version | Notes |
|---|---|---|
| [Node.js](https://nodejs.org) | 22 or later | npm included |
| **Csound** | **7.x** | Must be first on your `PATH` |
| AI API key | — | Gemini (free), Anthropic, or OpenAI |
| Git | any | For cloning |

---

## 1 — Install Node.js (v22+)

### macOS
```bash
brew install node@22
```

### Linux (Debian / Ubuntu)
```bash
curl -fsSL https://deb.nodesource.com/setup_22.x | sudo -E bash -
sudo apt install -y nodejs build-essential python3
```

### Linux (Fedora)
```bash
curl -fsSL https://rpm.nodesource.com/setup_22.x | sudo bash -
sudo dnf install -y nodejs gcc-c++ make python3
```

### Windows
Download Node.js 22 LTS from [nodejs.org](https://nodejs.org).

**Verify:** `node --version` → v22.x

---

## 2 — Install Csound 7

### macOS (recommended — user install)

```bash
# After installing Csound 7 pkg to ~/Applications/Csound/
mkdir -p ~/bin
ln -sf ~/Applications/Csound/csound ~/bin/csound
echo 'export PATH="$HOME/bin:$HOME/Applications/Csound:$PATH"' >> ~/.zshrc
source ~/.zshrc
csound --version   # must show version 7.x
```

If Homebrew Csound 6 is installed: `brew unlink csound` so it does not shadow Csound 7.

### Linux

Csound 7 may need to be built from source on some distros. See [Csound GitHub](https://github.com/csound/csound) and `WORKSHOP.md` in the repo.

```bash
sudo apt install build-essential cmake libjack-jackd2-dev   # Debian/Ubuntu deps
# build/install Csound 7, then:
csound --version
```

### Windows

Install Csound 7 from [csound.com/download](https://csound.com/download.html). Check **Add to PATH** during setup.

**Verify:** `csound --version` shows **7.x** (not 6.18).

---

## 2.5 — Install CsoundQt 7 (optional, recommended)

CsoundQt is the classic Csound IDE — great for editing, comparing with Dr.C output, and browsing the manual. Use the **Csound 7** build (v7.x beta), not the older Csound 6 releases.

**Releases:** [github.com/CsoundQt/CsoundQt/releases](https://github.com/CsoundQt/CsoundQt/releases) — pick **v7.0.0-beta3** or newer from the `csoundqt7` line.

### macOS

1. Install **Csound 7** first (§2 above).
2. Download `CsoundQt-*-MacOS.dmg` from the v7 release (plain version, not pythonqt).
3. Open the DMG and drag **CsoundQt** into **Applications**.
4. First launch: right-click → **Open** if Gatekeeper blocks it.
5. In Dr.C Standalone: **Settings → CsoundQt** should auto-detect `/Applications/CsoundQt.app`, or use **Choose CsoundQt…**.

### Linux

1. Install **Csound 7** first.
2. **Package manager** (if your distro ships a recent build):
   ```bash
   # Debian/Ubuntu — version may lag; prefer GitHub release if < 7.x
   sudo apt install csoundqt
   ```
3. **Recommended:** download the v7 **AppImage** from GitHub releases, make executable, and run:
   ```bash
   chmod +x CsoundQt-*-AppImage
   ./CsoundQt-*-AppImage
   ```
4. Dr.C auto-detects `csoundqt` on PATH; set **Settings → CsoundQt** if needed.

### Windows

1. Install **Csound 7** first and note its `bin` folder (e.g. `C:\Program Files\Csound7_x64\bin`).
2. Download `CsoundQt-*-Win64.zip` from the **v7** GitHub release and unzip.
3. Copy **all files** from the Csound 7 `bin` folder into the CsoundQt `bin` folder (overwrite if prompted) so CsoundQt finds `csound.exe` and plugins.
4. Run `CsoundQt.exe` (or `CsoundQt-d-html.exe` for HTML widget support).
5. Dr.C auto-detects under `Program Files\CsoundQt`; set path in **Settings → CsoundQt** if you use a custom folder.

**In the app:** artifact panel → **Open in CsoundQt** (plain CSD) or **Open in Cabbage** (plugin UI). Saved CSDs: `~/Documents/DrC/csoundqt/`.

---

## 2.6 — Install Cabbage (optional, recommended)

Cabbage builds live MIDI plugin UIs from Csound. Optional but recommended for the workshop — convert Dr.C artifacts and play with realtime controls.

**Downloads:** [cabbageaudio.com/download](https://cabbageaudio.com/download/) · [GitHub releases](https://github.com/cabbageaudio/Cabbage/releases)

### macOS

1. Download the macOS DMG and drag **Cabbage** into **Applications**.
2. First launch: right-click → **Open** if Gatekeeper blocks it.
3. Dr.C: **Settings → Cabbage** auto-detects `/Applications/Cabbage*.app`; use **Choose Cabbage…** if needed.

### Linux

1. Download the Linux AppImage or package from cabbageaudio.com.
2. **aarch64** (ARM laptops, Apple Silicon VMs): check releases for ARM builds — x86_64-only builds will not run natively.
3. `chmod +x Cabbage-*-AppImage && ./Cabbage-*-AppImage`
4. Dr.C auto-detects `cabbage` on PATH; set **Settings → Cabbage** if needed.

**In the app:** artifact panel → **Convert → Cabbage** → **Open in Cabbage**.

---

## 2.7 — Install Audacity (optional, recommended)

Audacity is useful for listening to Dr.C WAV exports, trimming clips, and comparing renders.

### macOS

```bash
brew install --cask audacity
```

Or download from [audacityteam.org/download](https://www.audacityteam.org/download/).

### Linux (Ubuntu 22.04)

```bash
sudo apt install audacity
```

Or Flatpak:

```bash
flatpak install flathub org.audacityteam.Audacity
```

---

## 2.8 — Install Reaper (optional, recommended)

Reaper is a lightweight DAW — handy as a VST host for Cabbage exports and for multitrack workshop demos.

**Download:** [reaper.fm/download.php](https://www.reaper.fm/download.php)

### macOS

1. Download the **macOS ARM64** (Apple Silicon) or **x86_64** (Intel) build.
2. Drag **REAPER.app** into **Applications** (or `~/Applications`).
3. First launch requires accepting the eval license (full license is optional).
4. Homebrew alternative: `brew install --cask reaper` (if the cask matches your architecture).

### Linux

1. Download the **Linux aarch64** or **x86_64** tarball from reaper.fm.
2. Extract and run `install-reaper.sh`, or unpack to `~/opt/REAPER` / `~/Applications/Reaper`.
3. **Eval license:** Reaper is free to evaluate with no time limit; purchasing a license is optional.
4. Both **aarch64** and **x86_64** Linux builds are available from the download page.

---

## 3 — Clone, install, configure

```bash
git clone https://github.com/mateolarreaferro/Dr.C-Standalone.git
cd Dr.C-Standalone
npm install
cp .env.example .env
```

Edit `.env` — at minimum one key:

```
GEMINI_API_KEY=your_key_from_aistudio.google.com
```

---

## 4 — Run (development — recommended for workshop)

### macOS / Linux
```bash
chmod +x scripts/launch-drc.sh
./scripts/launch-drc.sh
```

This prepends `~/bin` and `~/Applications/Csound` so **Csound 7 wins** over system Csound 6.

### Windows (PowerShell)
```powershell
$env:PATH = "$env:USERPROFILE\bin;$env:PATH"
npm run dev
```

### Workshop smoke test
```bash
export PATH="$HOME/bin:$HOME/Applications/Csound:$PATH"
csound -n -d -m0 -o /tmp/fm.wav resources/workshop-starters/fm_starter.csd
```

---

## 5 — Build installers (optional)

```bash
npm run dist:mac    # macOS .dmg
npm run dist:linux  # AppImage
npm run dist:win    # NSIS installer
```

Output in `release/`. Distribute these to attendees **after** you verify Csound 7 on each platform.

---

## macOS Gatekeeper (unsigned builds)

```bash
xattr -cr /path/to/DrC.app
```

Or right-click → **Open** once.

---

## Linux audio notes

- Compilation and web export work without audio hardware.
- Live play needs ALSA or JACK. For JACK, add to `<CsOptions>`: `-+rtaudio=jack -odac`
- If Electron fails to open: `sudo apt install libnss3 libatk-bridge2.0-0 libgtk-3-0 libxss1 libasound2`

---

## Windows notes

- SmartScreen: **More info** → **Run anyway** for unsigned installer.
- If `better-sqlite3` fails: install [Visual Studio Build Tools](https://visualstudio.microsoft.com/visual-cpp-build-tools/) with C++ workload.

---

## Troubleshooting

| Problem | Fix |
|---|---|
| Buggy first-generation CSDs | You are on Csound **6.18** or old v1.3.0 app. Use **v1.3.1+** from git and Csound **7** on PATH. |
| `csound: command not found` | Add Csound 7 to PATH (see §2). |
| Silent render | Check `0dbfs = 1` in CSD; verify with workshop starter: `resources/workshop-starters/fm_starter.csd` |
| AI no response | Set API key in `.env` or Settings → Test |

---

## Workshop prompt (copy-paste)

```
make a plain Csound CSD only — no Cabbage. Simple 2-operator FM synth with foscili, warm and resonant. Include score i 1 0 3 so it renders to WAV.
```

Golden starters ship in `Dr.C-Standalone/resources/workshop-starters/`.

---

← [Workshop README](./README.md) | [Dr.C Terminal →](./INSTALL-TERMINAL.md)
