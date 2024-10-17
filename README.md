# Historical Weather Forecast Comparison to Actuals
This is the practice project for IBM DevOps and Software Engineering Professional Certificate.

## Scenario
You've been tasked by your team to create an automated Extract, Transform, Load (ETL) process to extract daily weather forecast and observed weather data and load it into a live report to be used for further analysis by the analytics team. As part of a larger prediction modelling project, the team wants to use the report to monitor and measure the historical accuracy of temperature forecasts by source and station.

As a proof-of-concept (POC), you are only required to do this for a single station and one source to begin with. For each day at noon (local time), you will gather both the actual temperature and the temperature forecasted for noon on the following day for Casablanca, Morocco.

At a later stage, the team anticipates extending the report to include lists of locations, different forecasting sources, different update frequencies, and other weather metrics such as wind speed and direction, precipitation, and visibility.

## Data source
Here, we will use the weather data package provided by the open source project <a href="https://wttr.in/">wttr.in </a>, a web service that provides weather forecast information in a simple and text-based format. For further information, you can read more about the service on its <a href="https://github.com/chubin/wttr.in#readme">GitHub Repo</a>.

## What I learned
- Initialize the weather report log file
- Write a Bash script that downloads the raw weather data, and extracts and loads the required data
- Schedule the Bash script rx_poc.sh to run every day at noon local time
- Apply advanced Bash scripting to produce reporting metrics
- Create a script to report historical forecasting accuracy
- Create a script to report the minimum and maximum absolute errors for the week