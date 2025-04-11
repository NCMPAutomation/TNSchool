@echo off
set currentPath=%cd%
echo The current path is: %currentPath%
cd %currentPath%
powershell -ExecutionPolicy Bypass -File "TN_School_Script1.ps1"
python "TN_School_Script2.py"
echo Done!
pause
