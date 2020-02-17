# Convert a Unix timestamp to the real number of seconds
# elapsed since the epoch.

# Note: this script only manage additional leap seconds

# Download leap-seconds.list from
# https://github.com/eggert/tz/blob/master/leap-seconds.list

mkdir -p "$CACHE/atomic-time"

#wget -N -P "$CACHE/atomic-time" https://raw.githubusercontent.com/eggert/tz/master/leap-seconds.list

# Get current timestamp if nothing is given as first param
if [ -z $1 ]; then
    posix_time=$(date --utc +%s)
else
    posix_time=$1
fi

# Get the time at which leap seconds were added
#seconds_list=$(grep -v "^#" "$CACHE/atomic-time/leap-seconds.list" | cut -f 1 -d ' ')

# Find the last leap second (see the content of leap-seconds.list)
# 2208988800 seconds between 01-01-1900 and 01-01-1970:
#leap_seconds=$(echo $seconds_list | \
#	awk -v posix_time="$posix_time" \
#		'{for (i=NF;i>0;i--)
#			if (($i-2208988800) < posix_time) {
#				print i-1; exit
#			}
#		} END {if (($(i+1)-2208988800) == posix_time)
#		print "Warning: POSIX time ambiguity:",
#			posix_time,
#			"matches 2 values in UTC time!",
#			"The smallest value is given." | "cat 1>&2"
#		}')
#echo $leap_seconds

# Add the leap seconds to the timestamp
#seconds_since_epoch=$(($posix_time + $leap_seconds))
seconds_since_epoch=$(($posix_time + 37))

#date --utc -d "@$seconds_since_epoch"
echo "$(date --utc -d "@$seconds_since_epoch" +'%Y-%m-%d %H:%M:%S') TAI"
