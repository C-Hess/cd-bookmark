# cd-bookmark
## Description

Tired of making aliases like this to navigate the command line faster?
```bash
alias cdcode="cd ~/Documents/my-code-folder"
alias cddocs="cd ~/Documents"
alias cddesktop="cd ~/Desktop"
```

Is keeping track of the directory stack with `pushd` and `popd` too confusing?

Do you find yourself accidentally changing directories ruining your previous directory shortcut (`cd -`)?

With this script, you can quickly create persistent bookmarks for directories that you visit often allowing you to navigate the filesystem more quickly.

## Usage and Example
### Basic usage
To create a new bookmark, `cd` to the directory you wish to bookmark and run the command 
```bash
bm mybookmark
```
Now you can quickly change to that directory by running the command
```bash
cdbm mybookmark
```

The `cdbm` command comes complete with bash autocomplete support

### Temporary bookmark creation
Want to quickly mark a directory, but don't want to make a bookmark for it? Just run the `bm` and `cdbm` commands without an argument and it will bookmark the correct directory as a temporary/default directory bookmark

### Removing bookmarks
You can remove bookmarks by using the command:
```bash
bm [-r|--remove] <bookmark_name>
```

### List all bookmarks
If you want to print all of the bookmarks in a pseudo-tabular format, you can run the command:

```bash
bm [-p|--print]
```

## How it works
`cd-bookmark` maintains a file in your home directory (defaults to `~/.bkmrks`) that contains a list of all of the bookmarks you made and the directories they point to. This method avoids making alias that can clutter your command namespace while providing a more focused autocomplete.

## Installation instructions
To install, simply source the bash script in your main working environment. You can do this by adding either of the following lines to your .bashrc or .bash_profile


### ~/.bashrc
```bash
source ~/path-to-repo/cdbm.sh

# OR

. ~/path-to-repo/cdbm.sh
```


# Future work
- More error checking
- Better autocomplete support for the `bm` command

