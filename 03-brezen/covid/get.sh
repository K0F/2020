#!/bin/bash
wget "https://www.ecdc.europa.eu/sites/default/files/documents/COVID-19-geographic-disbtribution-worldwide-`date +%Y-%m-%d`.xlsx" || exit 1

ssconvert "COVID-19-geographic-disbtribution-worldwide-`date +%Y-%m-%d`.xlsx" "data/COVID-19-geographic-disbtribution-worldwide-`date +%Y-%m-%d`.csv"
rm "COVID-19-geographic-disbtribution-worldwide-`date +%Y-%m-%d`.xlsx"
FN="COVID-19-geographic-disbtribution-worldwide-`date +%Y-%m-%d`.csv"
cp covid.pde /tmp/
cat /tmp/covid.pde | sed "s+replaceme+`echo $FN`+g" > covid.pde
pp
exit 0
