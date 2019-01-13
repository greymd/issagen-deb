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
$ sudo apt-get update && sudo apt-get install -y imagemagick

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
