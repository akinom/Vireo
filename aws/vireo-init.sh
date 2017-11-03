#!/bin/bash 
#
# chkconfig: 2345 90 20
# run on level 2345


# Source function library.
. /etc/init.d/functions

VIREOUSER=ec2-user
VIREOHOME=/home/ec2-user/Vireo

case "$1" in
    start)
	sudo -u $VIREOUSER $VIREOHOME/reset.sh  origin/ec2
	sudo -u $VIREOUSER $VIREOHOME/aws/git_report | mail -s 'Vireo Restart' monikam@princeton.edu
        ;;
    stop)
        ;;
    status)
        ;;
    restart)
	sudo -u $VIREOUSER $VIREOHOME/reset.sh  origin/ec2
	sudo -u $VIREOUSER $VIREOHOME/aws/git_report | mail -s 'Vireo Restart' monikam@princeton.edu
        ;;
    *)
        echo "Usage:  {start|stop|status|restart"
        exit 1
        ;;
esac
sudo -u $VIREOUSER $VIREOHOME/play.sh $1 
exit $?
