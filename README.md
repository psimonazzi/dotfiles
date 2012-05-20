# @psimonazzi dotfiles

## “It's dangerous to go alone. Take This!”

My precious dotfiles for Linux (tested on Debian/Ubuntu). They keep my customizations for:

- Bash shell: prompt, terminal colors, fonts, sizes
- Emacs: a quite simple (for Emacs standards) .emacs full of ancient wisdom 
- Openbox: a minimal menu and a minimal graphical theme focused on typography
- Git: global config

## Installation

You place the files in `~/dotfiles`, symlinked in your home dir so programs can find them.
Sensitive data (user name, email, crypto keys etc.) is kept in a separate `~/.secrets` file, and exported as environment variables. To use these dotfiles you must create your secrets file, like this:

```bash
export GIT_AUTHOR_NAME='<your name>'
export GIT_AUTHOR_EMAIL='<your email>'
export GIT_COMMITTER_NAME='<your name>'
export GIT_COMMITTER_EMAIL='<your email>'
export GITHUB_USER='<your github username>'
export GITHUB_TOKEN='<your github token>'
```

### With Git

Clone the repository, then run a script to create the symlinks:

```bash
cd; git clone https://github.com/psimonazzi/dotfiles.git && cd dotfiles && ./bootstrap.sh
```

### Without Git

To install the files in your home dir, without cloning the Git repository (WARNING: existing files in your home dir will be overwritten!):

```bash
cd; curl -#L https://github.com/psimonazzi/dotfiles/tarball/master | tar -xzv --strip-components 1 --exclude={README.md,bootstrap.sh}
```

To update later on, just run the command again.

## Credits

Done in the spirit of http://dotfiles.github.com.
General setup and installation inspired by [mathiasbynens](https://github.com/mathiasbynens/dotfiles).
Emacs customizations taken from countless places: most are mentioned in the source.

