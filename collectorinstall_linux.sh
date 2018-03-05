yum update -y

hostnamectl set-hostname $1

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

yum install -y java
ifecho;
yum install -y wget
ifecho;
#hostnamectl set-hostname $1
firewall-cmd --permanent --add-port=6698-6699/tcp
firewall-cmd --permanent --add-port=2021/tcp
firewall-cmd --permanent --add-port=9911/tcp
firewall-cmd --permanent --add-port=8020-8021/tcp
firewall-cmd --permanent --add-port=9998-9999/tcp
firewall-cmd --reload

useradd -m dtcollector
cd /home/dtcollector
wget https://files.dynatrace.com/downloads/OnPrem/dynaTrace/7.0/7.0.0.2469/dynatrace-collector-7.0.0.2469-linux-x86.jar
ifecho;
java -jar dynatrace-collector-7.0.0.2469-linux-x86.jar
ifecho;
chown -R dtcollector:dtcollector dynatrace-7.0
su dtcollector

