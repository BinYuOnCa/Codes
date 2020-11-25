# What precisely happens when deleting a branch in Git

ref: https://stackoverflow.com/questions/34881412/what-precisely-happens-when-deleting-a-branch-in-git


Regardless of whether you delete with `git branch -d `or `git branch -D`, git removes **not the commits** but the **branch ref** only. 

Read on to see what that means.

## First, we will set up a simple demo history.

```bash 
$ touch initial ; git add initial ; git commit -m 'Initial commit'
[master (root-commit) 2182bb2] Initial commit
 1 file changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 initial

$ git checkout -b mybranch
Switched to a new branch 'mybranch'

```

At this point, both master and mybranch are pointing to the same commit, which we can verify in at least two ways.

```bash
$ git lola
* 2182bb2 (HEAD -> mybranch, master) Initial commit
```

Note that git lola is a non-standard but highly useful alias, equivalent to
```bash
$ git log --graph --decorate --pretty=oneline --abbrev-commit --all
* 2182bb2 (HEAD -> mybranch, master) Initial commit
```

We could set this alias via git config:
```bash
git config --global alias.lgda 'log --graph --decorate --pretty=oneline --abbrev-commit --all'

```

The other way we will look at after creating a new commit on mybranch.

$ touch mybranch ; git add mybranch ; git commit -m 'My branch'
[mybranch 7143aa4] My branch
 1 file changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 mybranch
After doing this, we do indeed have multiple commits on multiple branches.

$ git lola
* 7143aa4 (HEAD -> mybranch) My branch
* 2182bb2 (master) Initial commit
We can now peek at part of how git implements this under the hood.

$ ls -R .git/refs
.git/refs:
heads  tags

.git/refs/heads:
master  mybranch

.git/refs/tags:
Curious that there are files with the same names as our branches. Looking inside them, we see

$ cat .git/refs/heads/master .git/refs/heads/mybranch
2182bb2d5a0a7f57d0b74e95d37e208dac41f95b
2182bb2d5a0a7f57d0b74e95d37e208dac41f95b
So git implements refs as files in a certain location whose names match the branch names and that contain SHA1 hashes of certain commits. Observe that the abbreviated hash in the output from git lola (2182bb2) is the leading prefix of the cat output above.

Think of git refs as simple pointers that give human readable names to specific commits in your repository’s history.

Now if we switch back to master and zap mybranch

$ git checkout master ; git branch -D mybranch
Switched to branch 'master'
Deleted branch mybranch (was 7143aa4).
we see that the ref is gone

$ ls -R .git/refs
.git/refs:
heads  tags

.git/refs/heads:
master

.git/refs/tags:
but the commit is still there.

$ git show --pretty=oneline 7143aa4
7143aa477735382e7a0ed11c9e4b66c1f27583df My branch
diff --git a/mybranch b/mybranch
new file mode 100644
index 0000000..e69de29
If you want mybranch back, you need only run

$ git checkout -b mybranch 7143aa4
Switched to a new branch 'mybranch'
or

$ git branch mybranch 7143aa4
depending on, as the difference in their respective outputs indicates, whether you want to switch to the branch or not. In the latter case, where you stayed on your current branch, git lola looks like

$ git lola
* 7143aa4 (mybranch) My branch
* 2182bb2 (HEAD -> master) Initial commit
Yes, your commits hang around for a short time even after you delete the pointers that keep them alive. This can be tremendously useful in cases of accidental deletion. See also git reflog and git gc.

Note that the SHA1 hashes will be different in your repository because your name and email address, at least, will be different from what I used.

For completeness, the difference between -d and -D is the lowercase version is slightly safer.

-d
--delete

Delete a branch. The branch must be fully merged in its upstream branch, or in HEAD if no upstream was set with --track or --set-upstream.

-D

Shortcut for --delete --force.

-f
--force

Reset branchname to startpoint if branchname exists already. Without -f git branch refuses to change an existing branch. In combination with -d (or --delete), allow deleting the branch irrespective of its merged status …