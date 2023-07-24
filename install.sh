#!/bin/env bash

rsync -av .bashrc.d .shell_aliases.d .shell_functions.d ~/

chmod +x ~/.bashrc.d/*.sh
chmod +x ~/.shell_aliases.d/*.sh
chmod +x ~/.shell_functions.d/*.sh

#echo ". ~/.bashrc.d/init.sh" >>~/.bashrc
#exec bash
