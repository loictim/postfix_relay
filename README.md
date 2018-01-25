# postfix_relay
Postfix docker running as relay server

Sample usage :
docker run -d -p 25:25 -e MYNETWORK="127.0.0.1/32,172.17.0.0/24,192.168.0.0/16" \
                       -e HOSTNAME="test.example.com" \
                       postfix_relay
