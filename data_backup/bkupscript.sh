#!/bin/bash

DATETIME=`date +%y%m%d-%H_%M_%S`
SRC=$1
DST=$2
GIVENNAME=$3

tarandzip(){
	if /bin/tar -czvf $GIVENNAME-$DATETIME.tar.gz $SRC; then
		return 0
	else
		return 1
	fi
}

movetoSpace(){
	if /usr/local/bin/s3cmd put $GIVENNAME-$DATETIME.tar.gz s3://$DST; then
		return 0
	else
		return 1
	fi
}

if [ ! -z "$GIVENNAME" ]; then
	if tarandzip; then
		movetoSpace
	else
		return 0
	fi
else
	return 0
fi