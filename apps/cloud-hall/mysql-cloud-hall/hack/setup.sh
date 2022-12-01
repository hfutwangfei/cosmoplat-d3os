#!/bin/bash
set -e

echo "---service mysql status"

echo '---starting mysql....'
service mysql start

sleep 1

echo "---service mysql status"

echo '---data.sql importing....'
mysql < /mysql/sql/data.sql
echo '---data.sql imported....'

sleep 1

echo '---privileges.sql importing....'
mysql < /mysql/sql/privileges.sql
echo '---privileges.sql imported....'

sleep 1

echo "---service mysql status"

echo "---tar jdk..."
tar -zxvf /opt/jdk1.8.0_221.tgz  -C /opt/
sleep 1

rm -rf /opt/download
mkdir /opt/download
sleep 1
echo "---tar cloud..."
tar -xvf /opt/cloud.tar  -C /opt/download/
sleep 1

echo "---copy sources.list..."
cp /opt/sources.list /etc/apt/
#echo "---apt-get update -y..."
#apt-get update -y
#sleep 1
#echo "---apt-get install redis-server..."
#apt-get install redis-server -y
#sleep 1
#echo "---starting redis-server..."
#nohup redis-server > redis.log 2>&1 &
#sleep 1
#
#echo "---start cloud-hall..."
#nohup /opt/jdk1.8.0_221/bin/java -jar /opt/cloud-hall4.jar > cloud-hall.log 2>&1 &
#sleep 1

echo "success!"

tail -f /dev/null
