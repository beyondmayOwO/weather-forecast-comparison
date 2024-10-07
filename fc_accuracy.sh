# Extract Today's current Temperature
today_temp=$(tail -1 rx_poc.log | cut -d " " -f4)
echo "Today's temperature is $today_temp"

# Extract the forecasted temprature for today
forecasted_for_today=$(tail -2 rx_poc.log | head -1 | cut -d " " -f5)
echo "Forecasted temperature for today is $forecasted_for_today"

# Calculate the forecast accuracy by calculating the difference between today's temperature and forecasted temperature
if [ "$today_temp" -eq "$forecasted_for_today" ]
then
  echo "Today's temperature is the same as the forecasted temperature."
elif [ "$today_temp" -gt "$forecasted_for_today" ]
then
  hotter_temp=$(($today_temp-$forecasted_for_today))
  echo "Today's temperature is hotter by $hotter_temp"
elif [ "$today_temp" -lt "$forecasted_for_today" ]
then
  colder_temp=$(($forecasted_for_today-$today_temp))
  echo "Today's temperature is colder by $colder_temp"
fi