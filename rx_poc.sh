#! /bin/bash

city=Casablanca

#curl -s wttr.in/$city?T --output weather_report

#To extract Current Temperature
obs_temp=$(curl -s wttr.in/$city?T | grep -Pm 1 "°[CF]" | grep -Po "[+-]?\d+(?=[\(\s])")
echo "The current temperature of $city: $obs_temp"

# To extract the forecast temperature for noon tomorrow
fc_temp=$(curl -s wttr.in/$city?T | head -23 | tail -1 | cut -d 'C' -f2 | grep -Po "[+-]?\d+(?=[\(\s])")
echo "The forecast temperature for noon tomorrow for $city: $fc_temp"