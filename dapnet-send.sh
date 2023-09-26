#! /bin/sh

# configuration goes here
dapnet_username=n0call		# your username on hampager.de
dapnet_password=yOuRpAsSwOrD	# your corresponding password
dapnet_target=n0call		# the callsign to send the page to

# don't muck with this stuff
response_file="/tmp/dapnet-send.$$"
trap "rm -f $response_file" 0	# clean up on script exit

message="$*"
case "x$message" in
  x)
    echo "no message supplied"
    echo "usage: $0 message goes here"
    exit 1
    ;;
esac
json_1='{ "text": "'
json_2='", "callSignNames": ["'
json_3='"], "transmitterGroupNames": ["us-ut"], "emergency": false}'
json="${json_1}${message}${json_2}${dapnet_target}${json_3}"

curl -u $dapnet_username:$dapnet_password \
     -H "Content-Type: application/json" \
     -X POST \
     -d "$json" \
     https://hampager.de/api/calls > $response_file 2>&1

if grep -sq "violation" $response_file; then
  echo "message not sent"
  awk -F: '/message/ {print $2}' $response_file |
    sed -e 's/^ *"//' -e 's/"$//' | tr '[A-Z]' '[a-z]'
fi
