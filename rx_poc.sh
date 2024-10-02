#! /bin/bash

city=Casablanca

#curl -s wttr.in/$city?T --output weather_report

#To extract Current Temperature
obs_temp=$(curl -s wttr.in/$city?T | grep -Pm 1 "°[CF]" | grep -Po "[+-]?\d+(?=[\(\s])")
echo "The current temperature of $city: $obs_temp"