sudo apt-get -y update

# OPEN JDK
sudo apt-get -y install icedtea-7-plugin openjdk-7-jre openjdk-7-jdk

# Postgre SQL
sudo apt-get -y install postgresql

# Enable TCP/IP Postgre connections
sudo sed -i.bak s/"#listen_addresses = 'localhost'/listen_addresses = '\*'"/ /etc/postgresql/9.3/main/postgresql.conf 
sudo rm /etc/postgresql/9.3/main/postgresql.conf.bak

# Further PostgreSQL configuration
sudo cp ./pg_hba.conf /etc/postgresql/9.3/main/
sudo /etc/init.d/postgresql restart

# Servlet Engine: Apache Tomcat 7
sudo apt-get -y install tomcat7

# Create user dspace
sudo newusers ./users
sudo cp ./setenvvars.sh /etc/profile.d/

# Move Tomcat to port 80
# 80 is a privileged port and dspace is not authorized to run an app in that space
# sudo sed -i.bak s/8080/80/g /etc/tomcat7/server.xml 
# sudo rm /etc/tomcat7/server.xml.bak 

# Install installation tools
sudo apt-get -y install git
sudo apt-get -y install maven
sudo apt-get -y install ant

# Download source code
sudo -u dspace git clone https://github.com/inia-es/DSpace.git /home/dspace/dspace-source
cd /home/dspace/dspace-source/

# Move to version DSpace4.1
git checkout origin/dspace-4_x
git checkout -b dspace-4_x
git checkout dspace-4.1

# Create database and user
sudo -u postgres psql --file=./create.sql

# Create DSpace folder
sudo mkdir /dspace
sudo chown dspace /dspace

# Load dspace setup files
sudo cp ./build.properties /home/dspace/dspace-source/
sudo cp ./pom.xml /home/dspace/dspace-source/

# Build installation package
cp /home/dspace/dspace-source/dspace
sudo -u dspace mvn package

# Install DSpace and initialize database
cp /home/dspace/dspace-source/target/dspace-4.1-build
sudo -u dspace ant fresh-install

# Deploying web applications
sudo cp ./xmlui.xml /etc/tomcat7/Catalina/localhost
sudo cp ./jspui.xml /etc/tomcat7/Catalina/localhost
sudo cp ./oai.xml /etc/tomcat7/Catalina/localhost

# Should create administrator account in non interactive way
# ...

# Initial Startup - restart tomcat
sudo service tomcat7 restart
