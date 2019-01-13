# Debian package for [issagen](https://github.com/greymd/issagen)

## Manual build
Use Debian-based Linux like Ubuntu.

```sh

# --------------------
# Preparation
# --------------------

# Fill in the ttcp version number which you want to build.
$ VERSION="X.X.X"
$ git clone --recursive https://github.com/greymd/issagen-deb.git
$ cd issagen-deb
$ bash edit_changelog.sh
$ git diff
# => Check result and edit changelog as you like.
# Please refer to "Versioning" section in this file.

# Fetch issagen which has given VERSION
$ ( cd issagen.git; git checkout "v$VERSION" )
# => HEAD is now at XXXXXXX... Bump version to X.X.X

# --------------------
# Build
# --------------------

# Create directory for build.
$ cp -rL issagen-template issagen-${VERSION}
$ cd issagen-${VERSION}

# Install dependency before the build.
$ sudo apt-get update && sudo apt-get install -y tmux

# Dry build
$ debuild -us -uc
# => Check result.
# Answer "yes" is you asked something.
# If there is any errors like "E:error message", please solve it.

# Build (If you want to overwrite previous version, `debuild -S -sa`)
$ debuild -S -sd
# continue anyway? (y/n)
# => answer y

# Enter passphrase: gpg: gpg-agent is not available in this session
# => Enter passphrases of allowed GPG passphrase two times.

$ cd ..

# --------------------
# Install on local (Optional)
# --------------------

# Try installing
$ sudo dpkg -i issagen_${VERSION}*.deb

# Remove
$ sudo dpkg --remove issagen

# --------------------
# Upload to Launchpad
# --------------------

# For test
$ dput ppa:greymd/issagen-dev issagen_${VERSION}*_source.changes

# For production
$ dput ppa:greymd/issagen issagen_${VERSION}*_source.changes

# --------------------
# Cleaning
# --------------------
# Delete all the untracked files.
$ git ls-files --others --directory | xargs rm -rf

# --------------------
# Git
# --------------------
$ git add issagen-template
$ git add issagen.git
# => After that, git-commit and git-push

```

## Installation with APT

```sh
$ sudo apt-get -y install software-properties-common python-software-properties # if necessary

# For test
$ sudo add-apt-repository ppa:greymd/issagen-dev

# For production
$ sudo add-apt-repository ppa:greymd/issagen

$ sudo apt-get update
$ sudo apt-get install issagen

# Uninstall
$ sudo apt-get remove issagen
```

## Versioning
Basically, please refer to https://help.launchpad.net/Packaging/PPA/BuildingASourcePackage .
issagen does not require any compile, therefore suffix like `ubuntu<version num>` is not necessary. (@greymd thinks ... so, but it's not confident.)

Package version follows this rule.

```
issagen-<issagen version>-<build version>
```

For example

```
issagen-2.0.0-3
```

`<build version>` increments if same `<issagen version>` is built in multiple times.
`-0` is used if there is no retried build.

