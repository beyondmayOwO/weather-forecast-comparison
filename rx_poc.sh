#! /bin/bash
# This script extracts the weather report from the raw file and appends to the log

city=Casablanca

#curl -s wttr.in/$city?T --output weather_report

#To extract Current Temperature
obs_temp=$(curl -s wttr.in/$city?T | grep -Pm 1 "°[CF]" | grep -Po "[+-]?\d+(?=[\(\s])")
echo "The current temperature of $city: $obs_temp"

# To extract the forecast temperature for noon tomorrow
fc_temp=$(curl -s wttr.in/$city?T | head -23 | tail -1 | cut -d 'C' -f2 | grep -Po "[+-]?\d+(?=[\(\s])")
echo "The forecast temperature for noon tomorrow for $city: $fc_temp"

# Assign Country and City to variable TZ
TZ="Morocco/Casablanca"

# Use command substitution to store the current day, month, and year
hour=$(TZ="Morocco/Casablanca" date -u +%H)
day=$(TZ="Morocco/Casablanca" date -u +%d)
month=$(TZ="Morocco/Casablanca" date +%m)
year=$(TZ="Morocco/Casablanca" date +%Y)

# Append the report to the log
report=$(echo -e "$year\t$month\t$day\t$obs_temp\t$fc_temp")
echo $report >> rx_poc.log