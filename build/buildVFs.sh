#!/bin/bash

# Before running this script you must first run build-source-otfs.sh to make
# the ExtraLight and Heavy source OTFs used to create the variable fonts.
#
# Run this script to build all variable fonts or run the buildcff2vf command
# manually to build the desired designspace files.
# By default the fonts will be written to the designspace folder. 
# This can be changed by using the -o option on buildcff2vf to specify an 
# output location. 

BUILD_DIR=$(pwd)
script_tags=(JP KR CN TW HK)
locales=(J K SC TC HC)

function build_subset_vfs() {
    cd ../Masters/designspaces/Subset
    for tag in ${script_tags[@]}; do
        echo buildcff2vf -d SourceHanSerif${tag}-VF.designspace
        buildcff2vf --omit-mac-names -d SourceHanSerif${tag}-VF.designspace
    done
    cd ${BUILD_DIR} 
}

function build_vfs() {
    cd ../Masters/designspaces
    for loc in ${locales[@]}; do
        if [ ${loc} = "J" ]; then
            loc=""
        fi
        echo buildcff2vf -d SourceHanSerif${loc}-VF.designspace
        buildcff2vf --omit-mac-names -d SourceHanSerif${loc}-VF.designspace
    done
    cd ${BUILD_DIR} 
}


build_subset_vfs
build_vfs
