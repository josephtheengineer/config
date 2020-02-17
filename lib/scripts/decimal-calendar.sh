year_day=$(date +%j)
year=2020
month=0
day=0

# Month 0 (001 - 029)
# Month 1 (030 - 057)
# Month 2 (058 - 085)
# Month 3 (086 - 113)
# Month 4 (114 - 141)
# Month 5 (142 - 169)
# Month 6 (170 - 197)
# Month 7 (198 - 225)
# Month 8 (226 - 253)
# Month 9 (254 - 281)
# Month 10 (282 - 309)
# Month 11 (310 - 337)
# Month 12 (338 - 365)

echo "Year day: $year_day"
if (( $year_day == 1 )); then
	day=0
else
	day=$(expr $year_day - 1)
fi

echo "$year-$month-$day THC"
