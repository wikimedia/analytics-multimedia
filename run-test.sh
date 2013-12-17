#!/usr/bin/env bash

cat mv_headers.csv > mvdata.csv
cat mvp_headers.csv > mvpdata.csv
node crunch-eventlogging-data.js 2013-12-16 mvdata.csv mvpdata.csv types.csv sizes.csv < example.eventlogging
