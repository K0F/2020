#!/bin/bash
wget "https://www.ecdc.europa.eu/sites/default/files/documents/COVID-19-geographic-disbtribution-worldwide-`date +%Y-%m-%d`.xlsx" || { echo "cant get data from server" ; exit 1; }

ssconvert "COVID-19-geographic-disbtribution-worldwide-`date +%Y-%m-%d`.xlsx" "data/COVID-19-geographic-disbtribution-worldwide-`date +%Y-%m-%d`.csv"
rm "COVID-19-geographic-disbtribution-worldwide-`date +%Y-%m-%d`.xlsx"
FN="COVID-19-geographic-disbtribution-worldwide-`date +%Y-%m-%d`.csv"
sed -i "s+replaceme+`echo $FN`+g" covid.pde
pp
sed -i "s+`echo $FN`+replaceme+g" covid.pde
exit 0
