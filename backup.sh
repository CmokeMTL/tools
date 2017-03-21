#!/bin/bash
##              Interactive Local Backup Script
##          DEVIN COTE-MUNROE FOR DEVIN COTE-MUNROE
##                         3/20/2017
## EYE MAKED DIS >> YEWSIT


## STATIC VARS

FILEDATE="`date | awk -F " " '{ print tolower($2)"."$3"."$6 }'`"

## Present the application

echo
    echo -n " Hello "$USER", you are about to launch a simple backup application! "
    sleep 1
echo

## Select the file you wish to backup
## This is preferred over the commented out if statement following, though I decided to keep it in because knowledge is power

while [[  ! -d "$TOZIP" ]];do
    echo -n "Please enter an existing directory you wish to backup: "
	read TOZIP
    echo
done

################################################FOR KEEPSIES###############################################################
##Make sur the input corresponds with archivable data
#
#if [  ! -d "$TOZIP"  -a ! -f "$TOZIP"  ]; then
#    echo -n " $TOZIP is not a file or directory!! "
#    echo
#    exit 1
#else
#    echo
#    sleep 1
#        read -n1 -r -p " You have selected $TOZIP for backup, press any key to continue. "
#    echo
#fi
##########################################################################################################################

## Select the local directory in which to place the archive

sleep 1
    echo -n "Please enter the local backup destination: "
 	read LOCDEST

## Make sure there is a directory corresponding to input, if not prompt for input
while [  ! -d "$LOCDEST" ]; do
echo    
	echo -n " "$LOCDEST" is not a local directory, would you like to create it now?(Y/N): "
          read ANSWER

## Create directory if statement
 
	  if [[  "$ANSWER" =~ ^([yY][eE][sS]|[yY])+$  ]];then
      		sudo mkdir -p "$LOCDEST"
	  else
echo
		echo -n " Please enter the backup folder you want to create: "
		  read LOCDEST
	  fi
done

## On with the show


sleep 1
echo
    echo " You have selected "$LOCDEST" as your local backup directory. "
    read -n1 -r -p " Press any key to continue."

echo
	sudo tar czf "$LOCDEST"/"$HOSTNAME"."$USER"."$FILEDATE".tar.gz "$TOZIP"
sleep 1
echo .
sleep 1 
echo ..
sleep 2
echo ...

###QA###

if [  -f "$LOCDEST"/"$HOSTNAME"."$USER"."$FILEDATE".tar.gz  ];then
	echo "SUCCESS!! "$TOZIP" was backed up to "$LOCDEST" "
else
	echo " FAILED!! Please use valid input "
	exit 1
fi
sleep 1
echo ...

#COMING SOON: SCP TO REMOTE BACKUP SERVER
