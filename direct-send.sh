#! /bin/sh

ric=0123456	# your RIC goes here

message="$*"
case "x$message" in
  x)
    echo "no message supplied"
    echo "usage: $0 message goes here"
    exit 1
    ;;
esac

/usr/local/bin/RemoteCommand 7642 page "$ric" "$message" | grep -sq OK ||
  echo "message sending failed"

