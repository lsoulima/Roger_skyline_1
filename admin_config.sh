
#Update System##
------------------
apt-get update && apt-get upgrade

#Install Packages#
apt-get install -y vim sudo #fail2ban portsentry rsync openssl apache2 iptables-persistent

#Sudoers#
---------
usermod -aG sudo loubna

#ssh#
-----
echo "Port 1008" >> /etc/ssh/sshd_config
service ssh restart
#==> ssh connection : ssh loubna@ip -p1008

#Network#
---------
#avec root en serveur : $>chown loubna:loubna /etc/network/interfaces
scp -P 1008 /Users/lsoulima/Desktop/roger/ok/interfaces loubna@10.12.100.10:/etc/network/interfaces #n'oublies pas de changer l'@ selon l'etage
service networking restart

#iptables-restore < iptables
#iptables-save > /etc/iptables/rules.v4
#update-rc.d parefeu defaults

#firewall#
----------
mv iptables.sh /etc/init.d/parefeu
chmod +x /etc/init.d/parefeu
update-rc.d parefeu defaults

#Portsentry#
-----------
vi /etc/default/portsentry  #atcp, audp
service portsentry restart
# n'oublie pas d'ajouter mn @ip dans /etc/portsentry/portsentry.ignore.static

#==> To test :
nmap -v -PN -p 0-2000,60000 10.12.100.10
cat /etc/hosts.deny


#Fail2ban#
----------
suit fail2ban

#crontab#
---------

#Apache#
--------
cp resources/html/* /var/www/html
suit ssl
