#!/bin/bash

# user input
read -p 'Desired web port [8080]: ' web_port
web_port=${web_port:-8080}
read -p 'Desired agent port [50000]: ' agent_port
agent_port=${agent_port:-50000}

docker run \
  -u root \
  --rm \
  -d \
  -p $web_port:8080 \
  -p $agent_port:50000 \
  -v jenkins-data:/var/jenkins_home \
  -v /var/run/docker.sock:/var/run/docker.sock \
  --name=jenkins \
  jenkinsci/blueocean

# try to retrieve admin password
echo 'Trying to retrieve admin password of Jenkins. You can exit script (CTRL+C) and do this manually if you prefer.'
file=~/jenkins-admin-password.txt
end=$((SECONDS+240))
found=0
while [ $SECONDS -lt $end ] && [ $found -eq 0 ]; do
	# try to quietly retrieve the password file from container
	docker cp jenkins:/var/jenkins_home/secrets/initialAdminPassword $file >/dev/null 2>&1
	# check that file exists
	if [ -r $file ] && [ -s $file ]
	then
		admin_pass=$(< $file)
	fi
	# if password found print it to the user
	if [ ! -z "$admin_pass" ]
	then 
		found=1
		echo ''
		echo "Password found! Connect to jenkins ([jenkins_url]:$web_port) and enter the following password: "
		echo "$admin_pass"
	else 
		found=0
		echo -n "."
		sleep 2
	fi
done

rm $file

if [ $found -eq 0 ]
then
	echo Default password not found. Please try to connect to the container and find it by yourself. 
fi
	
