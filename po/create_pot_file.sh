#! /bin/sh
# create_pot_file.sh: create pot file for translation
# Meant to be run from the top level of the project directory

NAME=timeset
VER=1.6

# Change to the bin directory
cd bin

# Get the pot file
xgettext --from-code=UTF-8 --package-name=$NAME --package-version=$VER --msgid-bugs-address=aaditya_gnulinux@zoho.com \
	 --keyword=translatable --output=$NAME.pot $NAME.sh

# Move the pot file to the po folder
mv $NAME.pot ../po

exit 0
