# Notes related to what I learned while completing this

## Lesson 1: Navigating a Commit History

### To view the difference between two commits:

```bash
git diff <first-commit-id> <second-commit-id>
```

### How often to commit:

A good rule of thumb is to *make one commit per logical change*. For example,
if you fixed a typo, then fixed a bug in a separate part of the file, you
should use one commit for each change since they are logically separate.

### To see which files were changed between commits:

```bash
git log --stat
```

### To return to a previous commit:

```bash
git checkout <commit-id>
```

### Workflow to debug using git:

```bash
git log //Look through log to get commit ids
git checkout <commit-id> //Find last commit that didn’t have bug
git checkout master //Return to latest commit
git diff <id-of-last-commit-without-bug> <id-of-first-commit-with-bug>
//Examine code to see what caused the bug
```

## Lesson 2: Creating and Modifying a Repository

### To initialize a new git repository:

```bash
git init
```

### To add a file to the staging area:

```bash
git add <file_name>
```

### To commit changes in the staging area to the repository:

```bash
git commit -m <commit message>

//or to enter the message in the editor
git commit //no arguments
```

### To diff the working directory to the staging area:

```bash
git diff //no arguments
```

### To diff the staging area to the repository:

```bash
git diff --staged
```

### To discard all changes in the working directory:

```bash
git reset --hard
```

### To create a new branch:

```bash
git branch <branch_name>
```

### To create and checkout a new branch in one command:

```bash
git checkout -b <branch_name>
```

### To see graph of commits:

```bash
git log --graph --oneline <branch_names>
```

### To manually run garbage collection to delete unreachable branches:

```bash
git gc
```

### To merge branch_A into the current branch:

```bash
git merge branch_A
```

### To delete a branch:

```bash
git branch -d <branch_name>
```

### To compare a commit to its parent:

```bash
git show <commit_id>
```

## Lesson 3: Using GitHub to Collaborate

## To add a GitHub remote to a repository:

```bash
git remote add <remote_name> <remote_url> // remote_name is usually origin
```

## To push local changes to a branch to GitHub:

```bash
git push <remote_name> <branch_name>
```

## To pull remote changes to a branch from GitHub:

```bash
git pull <remote_name> <branch_name>
```

## To make a local copy of a GitHub repository:

```bash
git clone <GitHub_URL> // taken from GitHub
```
