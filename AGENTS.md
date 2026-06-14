# Repository Guidelines

## Project Structure & Module Organization

This repository is a small Python Telegram bot project. The main application lives in `bot.py`, which contains command handlers, username validation, storage helpers, and the async bot startup path. Runtime user state is stored in `users.json`; treat it as local data unless a change explicitly requires a seeded fixture. Dependencies are pinned in `requirements.txt`, and `start.bat` is the Windows convenience launcher. Generated folders such as `__pycache__/` should not be edited or committed.

## Build, Test, and Development Commands

- `python -m venv .venv` creates an isolated local environment.
- `.venv\Scripts\activate` activates the environment on Windows PowerShell or cmd.
- `pip install -r requirements.txt` installs `python-telegram-bot` and `httpx`.
- `python bot.py` runs the bot directly.
- `start.bat` installs dependencies, starts the bot, and keeps the console open on Windows.

Set configuration through environment variables before running, for example:

```powershell
$env:BOT_TOKEN="your-token"
$env:ADMIN_ID="123456789"
python bot.py
```

## Coding Style & Naming Conventions

Use Python 3 style with 4-space indentation. Keep functions in `snake_case`, constants in `UPPER_SNAKE_CASE`, and Telegram handler names descriptive, such as `start_cmd` or `button_handler`. Prefer type hints for new helper functions when inputs or return values are not obvious. Keep async Telegram handlers non-blocking; use `httpx.AsyncClient` or existing async patterns for network work.

## Testing Guidelines

No automated test suite is currently present. For new logic, add focused tests under `tests/` using `pytest`, especially for pure helpers such as username validation, storage transformations, and message formatting. Name files `test_<feature>.py` and tests `test_<behavior>()`. Until tests exist, validate changes with `python -m py_compile bot.py` and a manual bot run using a test token.

## Commit & Pull Request Guidelines

This working directory does not include Git history, so no local commit convention can be inferred. Use concise imperative commits, for example `Add username validation tests` or `Fix trap polling interval`. Pull requests should describe the behavior change, list manual or automated checks performed, mention configuration changes, and include screenshots or chat transcripts when Telegram output changes.

## Security & Configuration Tips

Do not hardcode real bot tokens, admin IDs, or private chat data. Prefer `BOT_TOKEN`, `ADMIN_ID`, and `CUSTOM_EMOJI_SET` environment variables. Avoid committing production `users.json`; use a small anonymized sample only when needed for tests or documentation.
