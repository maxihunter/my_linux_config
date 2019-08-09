#!/bin/sh
echo This is your transmission service. Torrent name: $1 has been complete. | ssmtp -v -s maxi_hunter@list.ru 2>&1 | tee -a domaillog
