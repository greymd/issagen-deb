#!/bin/bash
printf "VERSION: "
read VERSION < /dev/tty
cp -rL issagen-template issagen-${VERSION}
cd issagen-${VERSION}
debuild -S -sd
cd ..
dput ppa:issagen/ppa issagen_${VERSION}*_source.changes
git ls-files --others --directory | xargs rm -rf
