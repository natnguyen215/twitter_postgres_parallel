#!/bin/sh

files=$(find data/*)

echo '================================================================================'
echo 'load pg_denormalized'
echo '================================================================================'
time echo "$files" | parallel -j 10 sh load_denormalized.sh


echo '================================================================================'
echo 'load pg_normalized'
echo '================================================================================'
time echo "$files" | parallel -j 10 python3 load_tweets.py --db=postgresql://postgres:pass@localhost:1168/postgres --inputs


echo '================================================================================'
echo 'load pg_normalized_batch'
echo '================================================================================'
time echo "$files" | parallel -j 10 python3 -u load_tweets_batch.py --db=postgresql://postgres:pass@localhost:1169/postgres --inputs
