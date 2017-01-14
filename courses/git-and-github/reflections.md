# Important reflections while completing this item

## Lesson 1: Navigating a Commit History

How did viewing a diff between two versions of a file help you see the bug that
was introduced?

    Seeing only the changes between a working version and a non-working version
    narrows the focus, to make it easier to spot the bug.

How could having easy access to the entire history of a file make you a more
efficient programmer in the long term?

    It would make it easier to find bugs that came in between versions,
    or allow you to easily return to an older version. Thus saving lots
    of time in the long term.

What do you think are the pros and cons of manually choosing when to create a
commit, like you do in Git, vs having versions automatically saved, like Google
docs does?

    Automatic saving probably won't save exactly after each logical change.
    The only way to ensure this is to manually save.

Why do you think some version control systems, like Git, allow saving multiple
files in one commit, while others, like Google Docs, treat each file separately?

    Documents, such as the ones in Google Docs, are usually not interrelated.
    So they do not need to be saved together. Code, on the other hand is
    usually interrelated, so should be saved together.

How can you use the commands git log and git diff to view the history of files?

    git log --stat can tell you which files changed, and then git diff to view
    the changes.

How might using version control make you more confident to make changes that
could break something?

    It's easy to return the code to how it was at an earlier commit, so if
    something breaks it's an easy fix. Especially if you commit at each logical
    change.

## Lesson 2: Creating and Modifying a Repository

What happens when you initialize a repository? Why do you need to do it?

    The .git directory is created. This is where git stores all its metadata
    related to commits. You can't make any commits until a repository is
    initialized.

How is the staging area different from the working directory and the repository?
What value do you thing it offers?

    It contains changes that will be commited into the repository with the next
    `git commit`. The changes are not yet in the repository. It does not
    necessarily contain all the changes in the working directory. This gives
    fine grained control over what gets commited and when.

How can you use the staging area to make sure you have one commit per logical
change?

    Stage only one logical change before commiting, and any other logical
    changes in the working directory won't be included in that commit.
