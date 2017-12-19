#!/bin/sh

yum update
#Install Java
#echo $? 
#echo -e  "Test Begin \n\n\n\n"



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



yum -y install wget

ifecho;
#echo -e "\n\n"1234
#echo -e "\n\n\n\n\n"
#cd /etc/yum.repos.d
#wget http://download.opensuse.org/repositories/isv:ownCloud:community/CentOS_CentOS-6/isv:ownCloud:community.repo
#wget http://download.fedoraproject.org/pub/epel/6/i386/epel-release-6-8.noarch.rpm

#rpm -ivh epel-release-6-8.noarch.rpm

#yum install openjdk-8-jdk -y

yum install java -y
ifecho;
#Install Dynatrace
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



