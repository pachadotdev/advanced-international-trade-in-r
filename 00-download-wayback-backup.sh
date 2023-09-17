#!/bin/bash

# if dir does not exist
if [ ! -d "first-edition" ]; then
    # create dir
    mkdir first-edition

    wget \
    --recursive \
    --no-clobber \
    --page-requisites \
    --convert-links \
    --restrict-file-names=unix \
    --domains web.archive.org \
    --no-parent \
        https://web.archive.org/web/20050305085824/http://www.econ.ucdavis.edu/faculty/fzfeens/textbook.html

    # https://tonyteaches.tech/download-wayback-machine-website/
    # download the complete website for the first edition from the wayback machine
    
    # move all the zip files to the top level
    find . -name "*.zip" -exec mv {} . \;

    # move all zip files to first-edition/
    mv *.zip first-edition/

    # delete web.archive.org folder
    rm -rf web.archive.org
fi
