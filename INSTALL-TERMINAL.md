# Dr.C Terminal — Install Guide

Dr.C Terminal is a full-featured TUI (terminal UI) for AI-assisted Csound development. It runs in any terminal on macOS, Linux, or Windows and is built with [Bun](https://bun.sh).

**Source:** [github.com/csounder/drc-terminal](https://github.com/csounder/drc-terminal)

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

### Windows
Download and run the installer from [csound.com/download](https://csound.com/download.html).  
During install, check **"Add csound to PATH"**.

**Verify:**
```bash
csound --version
```

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
git clone https://github.com/csounder/drc-terminal.git
cd drc-terminal
bun install
```

`bun install` downloads all dependencies. It is fast (usually under 30 seconds).

---

## 4 — Add Your API Key

Copy the example env file and fill in at least one key:

```bash
cp .env.example .env
```

Open `.env` in any editor and add your key:

```
# Gemini 2.5 Flash — free from https://aistudio.google.com/apikey
GEMINI_API_KEY=your_key_here

# Optional fallbacks
ANTHROPIC_API_KEY=
OPENAI_API_KEY=
```

> The Gemini key must be an **AI Studio** key from `aistudio.google.com` — NOT a Vertex AI service account. Vertex credentials won't authenticate against the free Developer API endpoint.

---

## 5 — Run

```bash
bun run dev
```

This launches `drc`, the Dr.C TUI. You will see the welcome screen with Quick Start suggestions.

To run the built binary directly after a `bun run build`:
```bash
./bin/drc
```

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
