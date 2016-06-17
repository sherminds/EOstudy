#!/bin/bash

todaydate=$(date -r 1282368345 +%Y-%m-%d)

curl "https://docs.google.com/spreadsheets/d/1i67UACuGm4gKLlunEzIHdxCBSZJP2bhZWB3lSPkEocg/export?gid=0&format=csv" > data.csv
cp data.csv data${todaydate}.csv