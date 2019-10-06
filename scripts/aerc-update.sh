AERC_LOC=$(find /nix/store -name aerc | grep "/share/aerc")

cat ~/.config/aerc/main.conf > ~/.config/aerc/aerc.conf

echo "
[filters]
#
# Filters allow you to pipe an email body through a shell command to render
# certain emails differently, e.g. highlighting them with ANSI escape codes.
#
# The first filter which matches the email's mimetype will be used, so order
# them from most to least specific.
#
# You can also match on non-mimetypes, by prefixing with the header to match
# against (non-case-sensitive) and a comma, e.g. subject,text will match a
# subject which contains "text". Use header,~regex to match against a regex.
subject,~^\[PATCH=awk -f $AERC_LOC/filters/hldiff
text/html=$AERC_LOC/filters/html
text/*=awk -f $AERC_LOC/filters/plaintext
image/*=catimg -w $(tput cols) -" >> ~/.config/aerc/aerc.conf
