#! /usr/bin/env ash
set -e # exit on error


# Variables
if [ -z "$HOSTNAME"  ] ; then
	echo "HOSTNAME must be defined"
	exit 1
else
  postconf -e myhostname="$HOSTNAME"
  echo "$HOSTNAME" > /etc/mailname
fi
export PROTOCOL=${PROTOCOL:-"ipv4"}
export INTERFACE=${INTERFACE:-"all"}
export BANNER=${BANNER:-"$HOSTNAME ESMTP."}

if [ -z "$MYNETWORKS"  ] ; then
	postconf -e "mynetworks=127.0.0.1/32"
else
  postconf -e mynetworks="$MYNETWORKS"
fi
if [ -z "$MYNETWORKS"  ] ; then
	postconf -e "mynetworks=127.0.0.1/32"
else
  postconf -e "mynetworks=$MYNETWORKS"
fi

postconf -e inet_protocols=$PROTOCOL
postconf -e inet_interfaces=$INTERFACE
postconf -e recipient_delimiter=+
postconf -e mailbox_size_limit=0
postconf -e alias_database=hash:/etc/postfix/aliases
postconf -e alias_maps=hash:/etc/postfix/aliases
postconf -e smtputf8_enable=no
postconf -e smtp_use_tls=no

postconf -e "smtpd_banner=$BANNER"

/usr/sbin/postfix  start
