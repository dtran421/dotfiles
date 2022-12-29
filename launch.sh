#!/bin/bash

# Get the current hour
hour=$(date +%H)

# Greet the user based on the time of day
if [ $hour -ge 6 ] && [ $hour -lt 12 ]; then
  echo "Good morning, Duke!"
elif [ $hour -ge 12 ] && [ $hour -lt 18 ]; then
  echo "Good afternoon, Duke!"
else
  echo "Good evening, Duke!"
fi

# Get the current weather
weather=$(curl -s "wttr.in?format=%C+%t")

# Display the weather
echo "The current weather is: $weather"

# Display an ASCII drawing or animation
echo "
   .-.
  (   ).
 (___(__)
       '-'
"

