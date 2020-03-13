# Roger_skyline_1

##V.2 Partie VM

Creating VM
 RAM -> 1024 Mo
 HDD -> 8Go -> virtual hard disk -> VDI -> Fixed Size
 Add OS -> Settings -> Storage -> IDE -> Choose your favorite OS 
 Avoir au moins une partition de 4.2 Go (chercher la diff entre Gigabyte & GibiByte) |-> list partitions lsblk
 Updated
 All packages needed installed


##V.3 Partie Réseau et Sécurité

###V.3.1 Network Config
** Create a non-root user to connect to the machine and work. |-> Create User adduser |-> Add user to sudo group usermod -a -G sudo user1
** Don't use DHCP -> config IP fixe with Netmask en /30. |-> Config @IP in vim /etc/network/interfaces |-> Restart Network with sudo systemctl restart networking

###V.3.2 SSH Config
** SSH config file in vim /etc/ssh/sshd_config |-> Change default port #port 22 to port 1008 |-> Change protocol Protocol 2, 1 to Protocol 2, ssh2 is more secure than ssh1. |-> Root should not be allowed to access PermitRootLogin yes to PermitRootLogin no |-> Disable password login #PasswordAuthentication yes to PasswordAuthentication no and ChallengeResponseAuthentication yes to ChallengeResponseAuthentication no |-> Pub key enable #PubKeyAuthentication no to PubKeyAuthentication yes |-> Restart Service SSH sudo systemctl restart ssh |-> Try logging with new port ssh -p 1008 user@10.12.254.253 new port
** SSH access HAS TO be done with publickeys. |-> Generate SSH Keys with ssh-keygen  |-> Copy pub key to server ssh-copy-id -p 1008 user1@10.12.254.253 |-> Try logging with user1 ssh -p '1008' 'user1@10.12.254.253' |-> Doc => http://go2linux.garron.me/linux/2010/10/ssh-public-key-only-login-authentication-788/
** SSH publickeys for new user without passwd. |-> Create ~.ssh folder for user2 mkdir /home/user2/.ssh |-> Change permission chmod 777 /home/user2/.ssh |-> Copy pub key to home/.ssh user2 cp authorized_keys /home/user2/.ssh/ |-> Change Owner chown user2:user2 .ssh and chown user2:user2 authorized_keys |-> Try logging with user2 ssh -p '1008' 'user2@10.12.254.253'

###V.3.3 Script Config: Look at -> Script
** Create a script that updates all the sources of package, then your packages and qui log l’ensemble dans un fichier nommé /var/log/update_script.log.
** Create a scheduled task for this script once a week at 4AM and every time the machine reboots.
** Make a script to monitor changes of the /etc/crontab file and sends an email to root if it has been modified.
** Create a scheduled script task every day at midnight.

###V.3.4 Firewalling and Security Config
** Set Firewall rules for allow only the services used outside the VM: Look at -> iptables
** Set DOS protection on open ports of your VM: Look at -> fail2ban
** Set Portscan protection on open ports of your VM. |-> List open ports netstat -tulpn | grep LISTEN |-> https://www.digitalocean.com/community/tutorials/how-to-use-psad-to-detect-network-intrusion-attempts-on-an-ubuntu-vps
** Stop the services you don’t need for this project. |-> Show all services service --status-all systemctl list-units --type service | grep running


##Chapitre VI: Partie optionnelle

###VI.1 Partie Web
** Set a web server (Nginx or Apache) who should BE available on VM’s @IP |-> Install Apache apt-get install apache2 |-> WWW Folder is in cd /var/www/html/
** Set a self-signed SSL on all of your services
** Set a webapp (with any language you wan) from those choices ->for example login page.

###VI.2 Partie Déploiement

go2linux.garron.mego2linux.garron.me
ssh public key only login - authentication |
Open SSH private/public authenticationOpenSSH key public key authentication, let users log into server without the need to use their user’s passwords.It is p...

DigitalOceanDigitalOcean
How To Use psad to Detect Network Intrusion Attempts on an Ubuntu VPS | DigitalOcean
A network intrusion detection application can monitor your network interfaces for suspicious traffic and attempted security breaches. In this guide, we will configure a tool called psad to monitor our firewall logs and determine if there is a problem.(92 kB)
https://www.digitalocean.com/assets/community/illustrations/DigitalOcean_Community-02cc36407e7a978ed4fc9ed98f3ed87c.jpg
12:39

** Propose a functional solution for deployment automation. |-> Install FTP Server apt-get install vsftpd |-> Add user for FTP Server adduser ftpuser |-> Change home folder usermod -d /var/www ftpuser |-> Change owner chown ftpuser:ftpuser /var/www/ and chown ftpuser:ftpuser /var/www/html/ |-> Config vsftp in vim /etc/vsftpd.conf creat bak file config cp /etc/vsftpd.conf /etc/vsftpd.conf.bak Allow ftp users to write to the server write_enable=YES Deny ftp users browsing outside chroot_local_user=YES Give the correct permissions to the uploaded files local_umask=022 Force ftp to show files begin with dot like ".htaccess" add to the bottom this line force_dot_files=YES Bypass the writable check in ftp server add to the bottom this line allow_writeable_chroot=YES

** Use a <scp> in script..
  
** Use Git to synchronize changes..
