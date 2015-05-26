#! /bin/sh
# update_po_files.sh: script to update po files

NAME=timeset

# Change to the po directory
cd po

for i in *.po ; do
	msgmerge --update --backup=none $i $NAME.pot
done
