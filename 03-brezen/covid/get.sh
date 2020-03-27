#!/bin/bash
wget "https://www.ecdc.europa.eu/sites/default/files/documents/COVID-19-geographic-disbtribution-worldwide-`date +%Y-%m-%d`.xlsx"
ssconvert "COVID-19-geographic-disbtribution-worldwide-`date +%Y-%m-%d`.xlsx" "data/COVID-19-geographic-disbtribution-worldwide-`date +%Y-%m-%d`.csv"
rm "COVID-19-geographic-disbtribution-worldwide-`date +%Y-%m-%d`.xlsx"
