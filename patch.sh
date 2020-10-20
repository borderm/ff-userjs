#!/bin/bash

# Check if a copy of the ghack git repo survived
if [ -d /tmp/arkenfox ]; then
    if [ -d /tmp/arkenfox/.git ]; then
	# Git repo still exists, forcibly update it
	(cd /tmp/arkenfox &&
	    git reset --hard &&
	    git fetch --all &&
	    git rebase origin/master)
    else
	# Something exists, but it's not the git repo
	# Delete it with confirmation
	rm -r /tmp/arkenfox
	# Get the latest version
	git clone https://github.com/arkenfox/user.js.git /tmp/arkenfox
    fi
else
    # Get the latest version
    git clone https://github.com/arkenfox/user.js.git /tmp/arkenfox
fi

# Patch it
for patch in patches/*.patch; do
	echo "=== Applying $patch ==="
    patch -p0 -i $patch /tmp/arkenfox/user.js
done

# Copy it to the repo
cp /tmp/arkenfox/user.js .
