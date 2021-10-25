#!/bin/bash

# Run this script to build the ExtraLight and Heavy source OTFs used to 
# create the variable fonts.

weights=(ExtraLight Heavy)
script_tags=(JP KR CN TW HK)
script_ids=(1 3 25 2 2)
locales=(J K SC TC HC)

function build_subset_otfs() {
    for weight in ${weights[@]}; do
        for index in ${!script_tags[@]}; do
            tag=${script_tags[index]}
            sid=${script_ids[index]}
            makeotf -nshw -f ../Masters/${weight}/VF/cidfont.VF.${tag}.unhinted -omitMacNames -ff ../Masters/${weight}/VF/features.VF.${tag} -fi ../Masters/${weight}/cidfontinfo.${tag} -mf ../FontMenuNameDB.VF.SUBSET -r -nS -cs ${sid} -ch ../UniSourceHanSerif${tag}-UTF32-H -ci ../SourceHanSerif_${tag}_sequences.txt 
        done
    done
}

function build_otfs() {
    for weight in ${weights[@]}; do
        for index in ${!script_tags[@]}; do
            tag=${script_tags[index]}
            sid=${script_ids[index]}
            loc=${locales[index]}
            makeotf -nshw -f ../Masters/${weight}/OTC/VF/cidfont.VF.${loc}.unhinted -omitMacNames -ff ../Masters/${weight}/OTC/VF/features.VF.${loc} -fi ../Masters/${weight}/OTC/cidfontinfo.OTC.${loc} -mf ../FontMenuNameDB.VF -r -nS -cs ${sid} -ch ../UniSourceHanSerif${tag}-UTF32-H -ci ../SourceHanSerif_${tag}_sequences.txt 
        done
    done
}


build_subset_otfs
build_otfs
