#! /bin/bash

# configuration goes here
hampager_username="n0call"		# dapnet username
hampager_password="yOuRpAsSwOrD"	# dapnet password

# don't muck with stuff here
hampager_url="https://hampager.de/api/transmitters/$hampager_username"
error_state=$(curl -u $hampager_username:$hampager_password $hampager_url | 
              egrep -h "OFFLINE|ERROR" | wc -c)

if [ "$error_state" -gt 0 ]; then
  logger restarting dapnetgateway due to ERROR or OFFLINE state on hampager.de
  sudo systemctl stop dapnetgateway.service > /dev/null 2>&1
  sleep 5
  sudo systemctl start dapnetgateway.service > /dev/null 2>&1

  sleep 10
  /home/pi-star/dapnet-send.sh pi-star: restarted dapnetgateway service
else
  logger dapnetgateway is okay
fi
