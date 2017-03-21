#!/bin/bash
##              Interactive Remote Backup Script
##          DEVIN COTE-MUNROE FOR DEVIN COTE-MUNROE
##                         3/20/2017
## EYE MAKED DIS >> YEWSIT

## VARS
FILEDATE="`date | awk -F " " '{ print tolower($2)"."$3"."$6 }'`"
LOCDEST="/local.backup"

## Select and verify the remote host

echo -n " Please enter the IP of the remote backup server: "
	read RHOST
## Make sure IP is valid

while [[  !  "$RHOST"  =~  ^([1-9]{1,3}"."[1-9]{1,3}"."[1-9]{1,3}"."[1-9]{1,3})$  ]];do
	echo -n " Please enter a valid IP: "
	    read RHOST
done
echo

## Make sure backup host is up

		if [[    "$RHOST"  =~  ^([1-9]{1,3}"."[1-9]{1,3}"."[1-9]{1,3}"."[1-9]{1,3})$  ]];then
		echo
		    echo -n " IP is valid. Please hold while we verify the host is up: "
		    ping -q -c 3 "$RHOST"

## If host is not up choose ip if error

echo
		while [[  $?  !=  0  ]];do
			echo -n " Please enter the IP of a host that is UP: "
			  read RHOST
		#done
                    if [[    "$RHOST"  =~  ^([1-9]{1,3}"."[1-9]{1,3}"."[1-9]{1,3}"."[1-9]{1,3})$  ]];then
                      echo
                      echo -n " IP is valid. Please hold while we verify the host is up: "
                     ping -q -c 3 "$RHOST"

echo
		echo
		    fi
		done
		fi

## Select and verify the used Port number (if default press enter)

echo -n " Please enter the Port used to connect to the backup server enter 22 for default: " 
	read PORT

## Make sure the Port is a valid number
while [[ !  $PORT  =~ ^([0,2-9]{1,6})$  ]];do
	echo -n " Please enter a valid port number (up to 6 numbers between 0,2-9): "
	    read PORT
done

## Make sure the connection to the backup host with the selected tcp socket is possible
sleep 1
echo
echo -n " Testing to make sure your SSH socket will connect..."
echo
# if [[    "$RHOST"  =~  ^([1-9]{1,3}"."[1-9]{1,3}"."[1-9]{1,3}"."[1-9]{1,3})$  ]];then
	ssh -q  -p$PORT "$USER"@"$RHOST" exit  
 #fi
		    if [[  $?  == 0  ||   ! $PORT =~ ^([0,2-9]{1,6})$  ]];then
			echo -n " Connection is Possible!"
			echo
			echo
		    fi

	while [[  $? ==  255  ]];do 
	    echo -n "Wrong or invalid port number, try again: "
		read PORT
		ssh -q -p$PORT "$USER"@"$RHOST" exit

		    if [[  $?  == 0  ||   ! $PORT =~ ^([0,2-9]{1,6})$  ]];then
			echo -n " Connection is Possible!"
			echo
			 break
			echo
		    fi
	done
## Select the destination for the backup on the remote host
echo -n " Please select the remote backup directory: "
	read REMDEST
## Copy the file using the parameters
sudo scp -P $PORT "$LOCDEST"/"$HOSTNAME"."$USER"."$FILEDATE".tar.gz "$USER"@"$RHOST":"$REMDEST"
