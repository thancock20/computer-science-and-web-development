# Notes related to what I learned while completing this

### To view the difference between two commits:

    git diff *first-commit-id* *second-commit-id*

### How often to commit:

A good rule of thumb is to *make one commit per logical change*. For example,
if you fixed a typo, then fixed a bug in a separate part of the file, you
should use one commit for each change since they are logically separate.

### To see which files were changed between commits:

    git log --stat

### To return to a previous commit:

    git checkout *commit-id*
