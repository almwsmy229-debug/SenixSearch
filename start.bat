@echo off
echo Installing dependencies...
pip install -r requirements.txt
echo.
echo Starting UqozaSearch bot...
python bot.py
pause
