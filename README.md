# my personal dotfiles

These are my personal dotfiles. Free for personal use.

# My configured software

* i3 (window manager)
    * lockscreen support and autolock after idle
    * multi-monitor-setup via xmon
* vim
    * forked off [vimrc](https://github.com/bebehei/vimrc/)
    * NerdTree, autocompletion
    * colored
    * [git diff integration](https://github.com/mhinz/vim-signify)
* bash **and** zsh
    * keychain for automatic encryption of SSH-Keys
    * [liquidprompt](https://github.com/nojhan/liquidprompt)
    * zsh: [oh my zsh](https://github.com/robbyrussell/oh-my-zsh)
* small configuration for programs like:
    * wget
    * git
    * top

# You want to use them on your own?

1. Install the via `git clone` and `deploy.sh` (as described in Installation)
   - You may fork the repo, too!
2. Checkout a new branch != 'master'
3. Edit `git/gitconfig` and set your name + email.
4. Commit the stuff.
   - This prevents making commits in my name.

## Installation

Execute the following tasks somewhere. It really shouldn't matter.


    git clone https://github.com/bebehei/df
    cd df
    ./deploy.sh

This will fetch some other submodules and symlink every configfile in the system.

It won't overwrite your config-files, but only replace symlinks.
