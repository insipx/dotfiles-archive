#!/bin/bash

java -jar bfg-1.12.15.jar --delete-files $1 --no-blob-protection . &&
	git reflog expire --expire=now --all && git gc --prune=now --aggressive
