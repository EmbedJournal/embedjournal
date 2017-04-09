---
title: "Working with git from a Linux machine"
date: 2013-04-24T18:34:41+00:00
date_modified: 2017-04-01T10:00:00+05:30
author: Siddharth
thumbnail: post-thumb.png
permalink: /working-with-git-from-a-linux-machine/
dsq_thread_id: "3293147013"
category: "Linux"
tags: [ "CLI",  "git", Intro ]
---

{% include image.html src="git-logo.png" %}

After a long struggle I managed to learn the basics of working with git and use it effectively for the sake of code sharing and team work. I will document the steps for my own reference and to help others facing similar problems

### Create a repository

Creating a git repository is very simple. All you have to do is create an empty directory and issue a `git init` within it. Now when you `ls -la` in that directory you should see a `.git` directory. This is the only directory that git creates to work its magic.

You can set up your own git repository in another location and use that as the remote. If you do not have an account in github.com go ahead and create one. Create a repository using the create a new repository icon from the top right. Give a description (which is nothing right now) finish the remaining steps.

If this is the first time you are using git, then have to tell git who you are so your commits are tagged accordingly.

``` shell
$ git config --global user.name "Your Name Here"
$ git config --global user.email "Your Email"
```

You can omit the --global flag if you want a per-repository based configuration.

### Clone the repository

If you choose to make a copy of an existing git repository, you do what is called as a _clone_. This creates a local copy of the files. Be careful of what you clone, some projects can be a massive (just over few gigs!).

``` shell
$ git clone https://github.com/username/my-repositoy.git
```

### Add files to be committed

Once you have either created or cloned the repository, you can start modifying the files inside that directory or create new ones. Its up to you. Git keeps a track of all these changes.

Once you have edited some files, they are marked as _modified/added_. You can see this by typing `git status`. But these changes are locally made. You will have to stage them for a commit. Git had what is called as a staging area, where it lines up all the items that are to saved to the version history. For your _modified/added_ files to get to this area, you will have to _add_ them there.

``` shell
$ git add file-name  # to add file file-name to git.
$ git add dir-name   # to start tracking changes made to directory dir-name.
$ git add -A         # to add all. be careful
```

So far so good. You have successfully added files and directories into your commit stack.

### Commit local changes
Think of commit as a way to indicate changes made for a specific purpose on a bunch of files. This indication is given with a commit message.

``` shell
$ git commit -m 'my first commit'
```

Once your changes have been committed, if you run a `git status` again, you will notice that it says there is one local commit. This means that the commit that we just made, has not been sent out to any other remote git server. At this point if you deleted the files, you will loose that commit you just made.

### Push local commits to remote
Git is a distributed version control system. So you will have to push your changes to a remote machine for others to get your changes.

``` shell
$ git push origin master
```

You should give your username and password when prompted.
