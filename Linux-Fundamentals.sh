
#--------File System Navigation----------
# go root directory
cd /
# List the contents of the home directory.
cd home\
ls
# Change the current directory to /var/log and list its contents.
cd /var/log
ls
# Find and display the path to the bash executable using the which 
which bash
# Find current shell
echo $SHELL

#--------File System Navigation----------
# Create a directory named linux_fundamentals in your home directory.
cd /home
sudo su #to act as root user
mkdir linux_fundamentals
# Inside linux_fundamentals, create a subdirectory named scripts.
cd linux_fundamentals/
mkdir scripts
ls
# Create an empty file named example.txt inside the linux_fundamentals directory.
touch example.txt
# Copy example.txt to the scripts directory.
cp example.txt scripts\
ls -l scripts/
# Move example.txt from linux_fundamentals to linux_fundamentals/backup. Permissions
mkdir backup
mv example.txt backup/
ls -l backup/
# Change the permissions of example.txt to read and write for the owner, and read-only for the group and others.
#read-4, write-2, execute-1, nothing-0
#owner: -rw = 4+2 = 6
#group: r-- = 4 = 4
#other: --- = 0 = 0
cd backup/
ls -l 
chmod 640 example.txt
ls -l 

# Verify the permission changes using ls -l
ls -l 


#--------File Modification----------

# Create a file named example.txt in your home directory.
sudo touch example.txt
ls
# Change the owner of example.txt to a user named student
# output: students:x:1051
## create user 
sudo useradd student
cat /etc/passwd
stat -c %U example.txt # to check current file owner
## Change file owner
sudo chown student example.txt
stat -c %U example.txt
# Change the group of example.txt to a group named students.
## create group (create from any dir)
sudo groupadd students
cat /etc/group
ls -l example.txt #current USER and Group
sudo chown student:students example.txt #owner and group change
# Verify the changes using appropriate commands.
ls -l example.txt
#output: -rw-r--r-- 1 student students 0 Nov 30 13:37 example.txt

#--------Ownership----------
# Create a directory named project in your home directory.
ls
sudo mkdir project
ls
# Create a file named report.txt inside the project directory.
sudo touch report.txt project
# Set the permissions of report.txt to read and write for the owner, and read-only for the group and others.
#read-4, write-2, execute-1, nothing-0
#owner: -rw = 4+2 = 6
#group: r-- = 4 = 4
#other: r-- = 4 = 4
ls -l report.txt
sudo chmod 644 report.txt
ls -l report.txt
# Set the permissions of the project directory to read, write, and execute for the owner, and read and execute for the group and others
#read-4, write-2, execute-1, nothing-0
#owner: drwx = 4+2+1 = 7 #d-directory
#group: r-x = 4+1 = 5
#other: r-x = 4+1 = 5
sudo chmod 755 project/

# Verify the changes using appropriate commands.
ls -ld project/
### output: drwxr-xr-x 2 root root 4096 Nov 30 14:26 project/

#--------File System Navigation----------

# Create a new user named developer.
sudo useradd -u 2000 developer
# Set the home directory of the user developer to /home/developer_home.
sudo mkdir /home/developer_home
sudo usermod -d /home/developer_home -m developer
grep 'developer' /etc/passwd

# Assign the shell /bin/sh to the user developer.
sudo usermod -s /bin/sh developer
# Verify the new user's information.
grep 'developer' /etc/passwd
#output: developer:x:2000:2000::/home/developer_home:/bin/sh
# Change the username of the user developer to devuser.
sudo usermod -l devuser developer
grep 'developer' /etc/passwd
# Add devuser to a group named devgroup.
sudo groupadd -g 2001 devgroup
sudo usermod -aG devgroup devuser
groups devuser #to see groups of an user
# Set the password of devuser to devpass. ( hint: use passwd command. Run passwd --help to see available options)
sudo passwd devuser
#output: passwd: password updated successfully
# Verify the changes made to the user.
grep 'developer' /etc/passwd
devuser : developer devgroup

#--------Hard/Soft Link----------

# Create a file named original.txt in your home directory.  
sudo touch original.txt
ls 
# Create a symbolic link named softlink.txt pointing to original.txt.  
sudo ln -s ../home/original.txt ../home/softlink.txt
# Verify the symbolic link and ensure it points to the correct file.  
ls -al
ls -al | grep "original"
# Delete the original file original.txt and observe the status of the symbolic link.
ls -l softlink.txt
sudo rm original.txt
ls -l softlink.txt 
cat softlink.txt
# Create a file named datafile.txt in your home directory.  
sudo touch datafile.txt
ls
# Create a hard link named hardlink.txt pointing to datafile.txt.  
sudo ln ../home/datafile.txt ../home/hardlink.txt

# Verify the hard link and ensure it correctly points to the file.  
ls -l hardlink.txt 
# Check the inode of both datafile.txt and hardlink.txt.  
ls -i ../home/datafile.txt
ls -i ../home/hardlink.txt
# Delete the original file datafile.txt and observe the status of the hard link. 
sudo rm datafile.txt 
cat hardlink.txt 
##output: workable
# Find all .txt files in your home directory. ( use find command. Run find --help for usage)
find /home -type f -iname "*.txt" -exec basename {} \;

#i - ignore case sensitivity

# Update repo cache using apt/apt-get'
##recently updated its packages
sudo apt-get update 
# Install a package named tree
sudo apt-get update 
sudo apt-get install tree
tree --version
# Install gcloud CLI tool using apt ( Follow instructions from here: https://cloud.google.com/sdk/docs/install#deb )

sudo apt-get update
sudo apt-get install apt-transport-https ca-certificates gnupg curl

curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo gpg --dearmor -o /usr/share/keyrings/cloud.google.gpg
echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
sudo apt-get update && sudo apt-get install google-cloud-cli
RUN echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list && curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo gpg --dearmor -o /usr/share/keyrings/cloud.google.gpg && apt-get update -y && apt-get install google-cloud-cli -y
    
gcloud --version   
