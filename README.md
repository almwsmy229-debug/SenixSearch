# ⚡ SenixSearch

**A Telegram bot that hunts for free, rare usernames — and verifies every single one live against both Telegram and Fragment.**

[![Python](https://img.shields.io/badge/Python-3.10%2B-blue?logo=python&logoColor=white)](https://www.python.org/)
[![python-telegram-bot](https://img.shields.io/badge/python--telegram--bot-21.x-2CA5E0?logo=telegram&logoColor=white)](https://python-telegram-bot.org/)
[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

> 🇷🇺 Русская версия — [README.ru.md](README.ru.md)

Most "username checkers" only look at `t.me`. SenixSearch goes one step further: it
cross-checks **[Fragment](https://fragment.com)** — Telegram's official username
marketplace — so it never offers you a name that's actually sold, on auction, or
reserved. That's the difference between a username you *can* claim and one that
just *looks* free.

---

## ✨ Features

| | Feature | Description |
|---|---|---|
| 🔍 | **Free search** | Generates pronounceable candidates and returns **only** names that are genuinely claimable. |
| 5️⃣ | **Rare 5-letter search** | Most 5-letter names are locked behind Fragment — SenixSearch targets consonant‑cluster names (like `@xznow`) that Fragment never auctioned and are still free. |
| 🎭 | **Mask search** | `a?b?c`, where `?` is any letter. |
| ⭐ | **Rating search** | Finds high‑rarity names (length, rare letters, distinct characters). |
| 🪤 | **Traps** | Watches a taken username and notifies you the moment it frees up (background poller). |
| 💎 | **Premium decoration** | Animated Telegram Premium **custom emoji** rendered inside message text. |

Plus: inline‑button UI, per‑user daily limits, and a Premium tier — all in a single file.

---

## 🧠 How it works (the interesting part)

**1. Telegram availability.** Fetches `https://t.me/<username>`. A public entity
(user / bot / channel / group) always renders a `tgme_page_title` block; a free
username does not. Reverse‑engineered empirically against known taken/free names.

**2. Fragment cross-check.** Fetches `https://fragment.com/username/<name>` and reads
the status (`Available` / `Sold` / `Taken`) straight from the page. A name is
reported **free** only if it's free on `t.me` **and** absent from Fragment.

**3. The 5-letter insight.** Telegram moved virtually all *nice* 5‑letter usernames
to Fragment auctions — which is why naïve generators return names you can't claim
("username is invalid"). But cluster‑heavy names with rare letters
(`x z q j k w v`) were never auctioned and stay freely claimable. The generator
targets exactly those.

**4. Premium emoji rendering.** Telegram forbids combining `parse_mode` with
custom‑emoji entities in one message. SenixSearch ships a tiny renderer that builds
bold / monospace **and** custom‑emoji entities by hand (correct UTF‑16 offsets),
with graceful fallback when the bot owner has no Premium.

---

## 🛠 Tech stack

- **Python 3.10+**, fully `async`
- **[python-telegram-bot](https://python-telegram-bot.org/) 21.x**
- **[httpx](https://www.python-httpx.org/)** for async HTTP
- JSON file storage (no DB required)

---

## 🚀 Getting started

```bash
# 1. Create a bot via @BotFather and copy the token
# 2. Provide the token (pick one):
cp token.txt.example token.txt      # then paste your token inside
#    …or set an environment variable:  BOT_TOKEN=123456:ABC...

# 3. Install dependencies
pip install -r requirements.txt

# 4. Run
python bot.py
```

On Windows you can just double‑click **`start.bat`** (installs deps + runs the bot).

---

## 💬 Commands

| Command | What it does |
|---|---|
| `/start` | Main menu (inline buttons) |
| `/search <name>` | Check one username (Telegram + Fragment) |
| `/find <len>` | Find free usernames of a given length |
| `/mask a?b?c` | Mask search (Premium) |
| `/trap <name>` | Watch a username, get notified when free (Premium) |
| `/rating` | How the rarity score is calculated |
| `/decor` | Demo of premium custom‑emoji decoration |
| `/setemoji <pack>` | Plug in your own `t.me/addemoji/...` pack |

> The bot's user interface is in **Russian**.

---

## 📁 Project structure

```
bot.py                # the whole bot: handlers, checkers, generators, rendering
requirements.txt      # python-telegram-bot, httpx
start.bat             # Windows launcher
token.txt.example     # token template (real token.txt is git-ignored)
.env.example          # env-var alternative
```

---

## ⚠️ Notes

- Availability is verified through public web signatures (`t.me` + Fragment) — the
  most reliable method without a user MTProto session.
- Secrets and runtime data (`token.txt`, `users.json`, emoji configs) are
  **git‑ignored** and never committed.
- This project is for educational / portfolio purposes and is not affiliated with
  Telegram or Fragment.

## License

[MIT](LICENSE)
