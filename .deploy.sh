#!/bin/bash

set -e

md_notebook_path=/home/travis/build/jeffreyfei/random-notes
md_gen_path=~/md-notebook-gen
website_path=~/website

cd $md_notebook_path; ./indexer.sh
cd $md_gen_path; npm install; ./generate_notebook.sh $md_notebook_path
cd $website_path; rm -rf *
cp -r $md_gen_path/output/* $website_path/
cp $md_notebook_path/.index.html $website_path/index.html
cd $website_path; git add .; git commit -m "Travis Autobuild"; git push origin master
