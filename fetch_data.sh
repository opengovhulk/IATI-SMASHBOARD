#!/bin/bash
mkdir -p data/downloads/
wget "https://gist.github.com/Bjwebb/6726204/raw/errors" -O data/downloads/errors

python fetch_data.py

cd data/downloads
if [ ! -d ./6726204 ]; then
    git clone https://gist.github.com/6726204.git
fi
cd ./6726204
git checkout master > /dev/null
git pull > /dev/null
for commit in `git log --format=format:%H`; do
    git checkout $commit
    date=`git log -1 --format="%ai"`
    count=`cat errors | grep -v '^\.$' | wc -l`
    echo $date,$count
done > ../history.csv

