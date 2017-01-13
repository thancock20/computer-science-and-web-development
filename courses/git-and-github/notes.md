# Notes related to what I learned while completing this

## Lesson 1: Navigating a Commit History

### To view the difference between two commits:

```
git diff *first-commit-id* *second-commit-id*
```

### How often to commit:

A good rule of thumb is to *make one commit per logical change*. For example,
if you fixed a typo, then fixed a bug in a separate part of the file, you
should use one commit for each change since they are logically separate.

### To see which files were changed between commits:

```
git log --stat
```

### To return to a previous commit:

```
git checkout *commit-id*
```

### Workflow to debug using git:

```
git log //Look through log to get commit ids
git checkout *commit-id* //Find last commit that didn't have bug
git checkout master //Return to latest commit
git diff *id-of-last-commit-without-bug* *id-of-first-commit-with-bug*
//Examine code to see what caused the bug
```

## Lesson 2: Creating and Modifying a Repository

### To initialize a new git repository:

```
git init
```

### To add a file to the staging area:

```
git add *filename*
```
