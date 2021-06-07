# Useful Git Alias


git config --global alias.lgda 'log --graph --decorate --pretty=oneline --abbrev-commit --all'

git config --global alias.onfire "commit -a -m 'Commit -a -m  at Fire Alarm.'"


### list current alias
```
git config --get-regexp alias
```
Or, more memerable command:
```
git config --list | grep alias
```

ref: https://stackoverflow.com/questions/7066325/list-git-aliases
