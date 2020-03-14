#!/bin/bash
r=n
while [ $r != y ] 
do
	echo *################################*"      "Bienvenue au Script Du Déploiement"     "*#################################*
	echo "*#													 	#*"
	echo "*#     "Vous Voulez :" 												""#*"
	echo "*#     "1-Modifier un fichier dans le serveur"									""#*"
	echo "*#     "2-Ajouter un fichier dans le serveur"									""#*"
	echo "*#     "3-Supprimer un fichier dans le serveur"									""#*"
	echo "*#     "4-Exit"													""#*"
	echo "*#														#*"
	echo *################################################################################################################*
	read choix
	if [ "$choix" -eq 1 ]
	then
		rsync -e "ssh -p1008" -a --delete  loubna@10.12.100.8:/var/www/html/ /Users/lsoulima/Desktop/html/ 
		
		ls  /Users/lsoulima/Desktop/html/
		read file
		vim /Users/lsoulima/Desktop/html/$file
		rsync -e "ssh -p1008" -a --delete /Users/lsoulima/Desktop/html/ loubna@10.12.100.8:/var/www/html/	
	elif [ "$choix" -eq 2 ]
	then
		echo Entrer le path du fichier a ajouter
		read chemin
		rsync -e "ssh -p1008" -a $chemin loubna@10.12.100.8:/var/www/html/
	elif [ "$choix" -eq 3 ]
	then
		rsync -e "ssh -p1008" -a  loubna@10.12.100.8:/var/www/html/ /Users/lsoulima/Desktop/html/
		ls  /Users/lsoulima/Desktop/roger_d/html/
		read file
		rm /Users/lsoulima/Desktop/html/$file
		rsync -e "ssh -p1008" -a --delete /Users/lsoulima/Desktop/html/ loubna@10.12.100.8:/var/www/html/
	else	
		echo " Do you really want to exit the program ? [y/n]"
		read r 
	fi
done
