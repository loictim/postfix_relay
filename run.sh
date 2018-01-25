#!/usr/bin/env ash
set -e # exit on error


# Variables
if [ -z "$HOSTNAME"  ] ; then
	echo "HOSTNAME must be defined"
	exit 1
else
  export HOSTNAME
  postconf -e myhostname="$HOSTNAME"
  echo "$HOSTNAME" > /etc/mailname
fi
export PROTOCOL=${PROTOCOL:-"ipv4"}
export INTERFACE=${INTERFACE:-"all"}
export BANNER=${BANNER:-"$HOSTNAME ESMTP."}
export MYNETWORKS=${MYNETWORKS:-"127.0.0.1/32"}

postconf -e "mynetworks=$MYNETWORKS"
postconf -e "inet_protocols=$PROTOCOL"
postconf -e "inet_interfaces=$INTERFACE"
postconf -e recipient_delimiter=+
postconf -e mailbox_size_limit=0
postconf -e "alias_database=hash:/etc/postfix/aliases"
postconf -e "alias_maps=hash:/etc/postfix/aliases"
postconf -e smtputf8_enable=no
postconf -e smtp_use_tls=no

postconf -e "smtpd_banner=$BANNER"

/usr/lib/postfix/master -d
