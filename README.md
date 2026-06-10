# Dr.C — LAC 2026 Workshop

**From Zero to Web Audio: Building Csound-Powered Apps with Dr.C**  
Linux Audio Conference · Maynooth, Ireland · June 18–20, 2026

Dr.C is an open-source, domain-specialized AI assistant for Csound. It implements an alternatives-first design paradigm — proposing multiple synthesis approaches before executing any of them — so the human stays in creative control throughout. It ships in two forms: a terminal TUI and a desktop (Electron) app.

**MIT license · [github.com/csounder](https://github.com/csounder)**

---

## Papers

| Document | Description |
|---|---|
| [Dr.C-Paper-LAC2026.pdf](./Dr.C-Paper-LAC2026.pdf) | Conference paper: architecture, alternatives-first paradigm, educational deployment |
| [Dr.C-Workshop-LAC2026.pdf](./Dr.C-Workshop-LAC2026.pdf) | Workshop proposal: structure, activities, hackathon brief |

---

## Before the Workshop

**Please complete installation before arriving.** The workshop moves fast — 30 minutes of guided coding, then a 60-minute hackathon. If you arrive with everything installed and a working API key, you will be ready to build on day one.

Choose one version (or both):

| Version | Best for | Requirements |
|---|---|---|
| **Dr.C Terminal** | Developers who live in the terminal | Bun 1.3.9+, Csound, API key |
| **Dr.C Standalone** | Everyone; graphical Electron app | Node.js ≥ 20, Csound, API key |

---

## Quick Install Summary

### Step 1 — Install Csound

Both versions shell out to the `csound` CLI. Install it once.

**macOS**
```bash
brew install csound
```

**Linux (Debian/Ubuntu)**
```bash
sudo apt update && sudo apt install csound
```

**Linux (Fedora/RHEL)**
```bash
sudo dnf install csound
```

**Linux (Arch)**
```bash
sudo pacman -S csound
```

**Windows**  
Download the installer from [csound.com/download](https://csound.com/download.html) and run it. Make sure "Add to PATH" is checked.

Verify:
```bash
csound --version
```

---

### Step 2 — Get an API Key

Dr.C defaults to **Gemini 2.5 Flash**, which is free with a Google AI Studio key. You do not need a paid account.

1. Go to [aistudio.google.com/apikey](https://aistudio.google.com/apikey)
2. Sign in with a Google account → **Create API Key**
3. Copy the key — you will paste it into Dr.C's Settings page (or `.env`) during install

> Anthropic and OpenAI keys also work if you have them. Gemini is recommended for the workshop because it is free and has no rate-limit surprises.

---

### Step 3 — Install and Run Your Chosen Version

- **[Dr.C Terminal — full install guide →](./INSTALL-TERMINAL.md)**
- **[Dr.C Standalone — full install guide →](./INSTALL-STANDALONE.md)**

---

## Workshop Repo Structure

```
DrC/                          ← this repo
├── README.md                 ← you are here
├── INSTALL-TERMINAL.md       ← TUI version install guide
├── INSTALL-STANDALONE.md     ← Electron version install guide
├── Dr.C-Paper-LAC2026.pdf    ← conference paper
└── lac-Dr.C-workshop-proposal.pdf ← workshop proposal
```

The source code lives in separate repositories linked from each install guide.

---

## On the Day

1. Open a terminal (or the Standalone app)
2. Type something like: `make a simple FM synthesizer with a warm, resonant character`
3. Dr.C proposes 3 alternatives — pick one, it renders, you hear it
4. Iterate from there

Bring headphones. You will want to hear your own work during the hackathon.

---

## Contact

**Dr. Richard Boulanger** — rboulanger@berklee.edu  
Professor of Electronic Production and Design, Berklee College of Music

**Mateo Larrea** — mlarreaf@stanford.edu  
CCRMA, Stanford University
