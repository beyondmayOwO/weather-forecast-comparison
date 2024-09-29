#! /bin/bash

# Write the header row to the log file
header=$(echo -e "year\tmonth\tday\tobs_tmp\tfc_temp")
echo $header >> rx_poc.log