@echo off
curl -s -o nul -w "%%{http_code}" http://laravel.ir/modules > status.txt
set /p status=<status.txt
del status.txt
if "%status%"=="200" (
    del modules.json > nul 2>&1
    curl -o modules.json http://laravel.ir/modules
)

git checkout main
git checkout --orphan new-main
git add -A
git commit -m "Initial commit: Squashed all previous history"
git branch -D main
git branch -m main
git push -f origin main
git reflog expire --expire=now --all
git gc --prune=now --aggressive