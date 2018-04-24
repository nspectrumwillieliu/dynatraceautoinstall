yum update -y
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


firewall-cmd --permanent --add-port=6698-6699/tcp
firewall-cmd --permanent --add-port=9998-9999/tcp
firewall-cmd --reload


cd /opt
ifecho;
java -jar dynatrace-collector-*.jar
ifecho;

cd dynatrace-*/collector/conf
#vi collector.config.xml
val=`/usr/bin/cat /opt/dynatrace-*/collector/conf/collector.config.xml`
#echo $val | awk -F'localhost' '$1'
echo $val | sed 's/localhost/'$1'/g' > /opt/dynatrace-6.5/collector/conf/collector.config.xml

cd dynatrace-6.5/

./dtcollector -bg

