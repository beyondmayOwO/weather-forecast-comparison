#! /bin/bash
# This script reports weekly statistics of historical forecasting accuracy

reports=()
reports_file="synthetic_historical_fc_accuracy.tsv"

while read -r report; do
  reports+=("$report")

  # Extract accuracy and calculate the absolute maximum and minimum error
  accuracy=$(echo $report | cut -d " " -f6)
  [ "$accuracy" -lt 0 ] && accuracy=$((-accuracy))

  if [ $accuracy -ge 5 ] && [ "$accuracy" -lt 10 ]; then
    maximum=$accuracy
    echo "Maximum absolute error = $maximum"
  elif [ "$accuracy" -eq 0 ]; then
    minimum=$accuracy
    echo "Minimum absolute error: $minimum"
  fi
done < <(tail +2 $reports_file)

echo ${reports[@]}