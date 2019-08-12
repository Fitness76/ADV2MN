



#!/bin/bash
# nodemon 2.0 - ADV2 Masternode Monitoring

#Processing command line params
if [ -z $1 ]; then dly=5; else dly=$1; fi   # Default refresh time is 5 sec

datadir="$HOME/.adevplus20$2"   # Default datadir is /root/.adevplus20

# Install jq if it's not present
dpkg -s jq 2>/dev/null >/dev/null || sudo apt-get -y install jq

echo '\n\nPress Ctrl-C to Exit...'


#It is a one-liner script for now
watch -ptn $dly "echo '===========================================================================
Outbound connections to other adevplus20 nodes [adevplus20 datadir: $datadir]
===========================================================================
Node IP               Ping    Rx/Tx     Since  Hdrs   Height  Time   Ban
Address               (ms)   (KBytes)   Block  Syncd  Blocks  (min)  Score
==========================================================================='
sudo adevplus20-cli -datadir=$datadir getpeerinfo | jq -r '.[] | select(.inbound==false) | \"\(.addr),\(.pingtime*1000|floor) ,\
\(.bytesrecv/1024|floor)/\(.bytessent/1024|floor),\(.startingheight) ,\(.synced_headers) ,\(.synced_blocks)  ,\
\((now-.conntime)/60|floor) ,\(.banscore)\"' | column -t -s ',' &&
echo '==========================================================================='
uptime
echo '==========================================================================='
echo 'Masternode Status: \n# adevplus20-cli masternode status' && sudo adevplus20-cli -datadir=$datadir masternode status
echo '==========================================================================='
echo 'Sync Status: \n# adevplus20-cli mnsync status' && sudo adevplus20-cli -datadir=$datadir mnsync status
echo '==========================================================================='
echo 'Masternode Information: \n# adevplus20-cli getinfo' && sudo adevplus20-cli -datadir=$datadir getinfo
echo '==========================================================================='
echo 'Usage: nodemon.sh [refresh delay] [datadir index]'
echo 'Example: nodemon.sh 10 22 will run every 10 seconds and query adevplus20d in /$USER/.adevplus2022'
echo '\n\nPress Ctrl-C to Exit...'"







