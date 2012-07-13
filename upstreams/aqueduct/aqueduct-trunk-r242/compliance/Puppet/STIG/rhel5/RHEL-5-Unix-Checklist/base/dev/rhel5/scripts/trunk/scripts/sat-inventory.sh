#!/bin/bash -x 

# collect all "inventory" info for the satellite server.

# much run on the satellite host remote not possible.

for options in `spacewalk-report`;do
  spacewalk-report $options > /var/www/html/inventory/$options.csv
done