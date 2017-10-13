#!/bin/bash 
#
# chkconfig: 2345 90 20
# run on level 2345


# Source function library.
. /etc/init.d/functions

VIREOUSER=ec2-user
VIREOHOME=/home/ec2-user/Vireo
PLAY=/home/ec2-user/play1/play

case "$1" in
    start)
	sudo -u $VIREOUSER $VIREOHOME/aws/vireo.sh $PLAY $1
        ;;
    stop)
	sudo -u $VIREOUSER $VIREOHOME/aws/vireo.sh $PLAY $1
        ;;
    status)
	sudo -u $VIREOUSER $VIREOHOME/aws/vireo.sh $PLAY $1
        ;;
    restart)
	sudo -u $VIREOUSER $VIREOHOME/aws/vireo.sh $PLAY stop
	sudo -u $VIREOUSER $VIREOHOME/aws/vireo.sh $PLAY start
        ;;
    *)
        echo "Usage:  {start|stop|status|restart"
        exit 1
        ;;
esac
exit $?
