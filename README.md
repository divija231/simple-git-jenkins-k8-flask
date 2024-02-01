create an instance and one cluster having 2 nodes in gcp
make an ssh connection to the instnace that you have created
install jenkins,docker, and kubectl in that instance
**#for java installation**
sudo add-apt-repository ppa:openjdk-r/ppa
sudo apt-get update
sudo apt install openjdk-11-jdk
**#for jenkins installation**
sudo apt update
sudo wget -O /usr/share/keyrings/jenkins-keyring.asc   https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc]   https://pkg.jenkins.io/debian-stable binary/ | sudo tee   /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt-get update
sudo apt-get install jenkins
jenkins --version
sudo systemctl status jenkins


**for docker installation**
apt install docker.io -y
 docker --version 
 usermod -aG docker jenkins
**for kubectl installation**
 snap install kubectl --classic


** pluggins to install in jenkins**
maven invoker
maven integration
docker pipeline
google kubernetes engine


iam service account
tools>> Maven
credentials>>secrettext (id dockerhub) and google service account fropm private key --(id kubernetes)
