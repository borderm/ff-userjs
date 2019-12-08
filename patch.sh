#!/bin/bash

# Check if a copy of the ghack git repo survived
if [ -d /tmp/ghacks ]; then
    if [ -d /tmp/ghacks/.git ]; then
	# Git repo still exists, forcibly update it
	(cd /tmp/ghacks &&
	    git reset --hard &&
	    git fetch --all &&
	    git rebase origin/master)
    else
	# Something exists, but it's not the git repo
	# Delete it with confirmation
	rm -r /tmp/ghacks
	# Get the latest version
	git clone https://github.com/ghacksuserjs/ghacks-user.js.git /tmp/ghacks
    fi
else
    # Get the latest version
    git clone https://github.com/ghacksuserjs/ghacks-user.js.git /tmp/ghacks
fi

# Patch it
for patch in *.patch; do
    patch /tmp/ghacks/user.js < $patch
done

# Copy it to the repo
cp /tmp/ghacks/user.js .
