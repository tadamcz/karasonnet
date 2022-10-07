#!/bin/zsh
./generate.sh
SYS_KARA=~/.config/karabiner
cp $SYS_KARA/karabiner.json $SYS_KARA/automatic_backups/karabiner_$(date -u +"%Y_%m_%d_T_%H_%M_%S").json
cp karabiner.json $SYS_KARA