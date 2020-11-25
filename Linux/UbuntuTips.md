# Ubunut Tips 


#### Shell prompt

In Ubuntu the default Prompt setting is defined in ~/.bashrc, we could customized it here as per your request.
 
```bash
if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi

```
Sometimes if the path too long, we could like to shortten the prompt.
Three options could be considered:
(1) use \W instead of \w, which only show the current working folder;
(2) add a '\n' at the end of the path so that the '$' will always in the beginning of a new line;
(3) set evn PROMPT_DIRTRIM=n, where n specifies the depth of the directory to show. Set n=1 is equivalent to (1).

I perfer (3), just adding the following line to the end of ~/.bashrc, and restart the session:
```bash
echo 'export PROMPT_DIRTRIM=3'>>~/.bashrc
```

#### Symbolic link 

tag: docker, wsl 

When I work in an ubuntu docker inside a Windows 10, we could access host file system mounted at /mnt/c. The home directory of Windows would be /mnt/c/Users/YourName, we could make a symbolic link under ubuntu home direction ~ to easy our job:

```bash
ln -s /mnt/c/Users/BY1711/ hostHome

``` 


Another secenario of using symolic link is track data in git. Say in one jira we need use the data from another jira, instead of copy the data to current folder, the better approach is to create a symbolic link points to the file, so we alwasy get the latest data.




