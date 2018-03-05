#!/bin/sh

yum  -y update

#Judge Command success or not
function ifecho()
{
	if [ $? -eq 0 ];
	then 
		echo "command success"
		#exit 0

	else	
		echo "Last Command had something wrong!" 
		exit 0
	fi
}


#安裝 wget 指令 
yum -y install wget

ifecho;
#yum install openjdk-8-jdk -y
yum install java -y
ifecho;
#Install Dynatrace

#設定Host Name
hostnamectl set-hostname dtserver

wget https://files.dynatrace.com/downloads/OnPrem/dynaTrace/7.0/7.0.0.2469/dynatrace-full-7.0.0.2469-linux-x86-64.jar
ifecho;
cp dynatrace-full-7.0.0.2469-linux-x86-64.jar /opt
cd /opt
java -jar dynatrace-full-7.0.0.2469-linux-x86-64.jar -y
ifecho; 
cd dynatrace-7.0/init.d
cp dynaTrace* /etc/init.d
cd /etc/init.d
chkconfig dynaTraceAnalysis on
chkconfig dynaTraceServer on
chkconfig dynaTraceCollector on
chkconfig dynaTraceWebServerAgent on
ifecho;
firewall-cmd --permanent --add-port=6698-6699/tcp
firewall-cmd --permanent --add-port=2021/tcp
firewall-cmd --permanent --add-port=9911/tcp
firewall-cmd --permanent --add-port=8020-8021/tcp
firewall-cmd --reload
reboot
