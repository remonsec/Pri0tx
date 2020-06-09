#!/bin/bash

#Color 
DO="\e[0;49;95m"
PINK="\e[0;49;35m"
RED="\e[0;49;31m"
GREEN="\e[0;49;91m"
Gcyan="\e[0;49;33m"
Cyan="\e[0;49;36m"
STOP="\e[0m"

#Banner
echo -e "${Cyan}
 _____     _ ___ _       
|  _  |___|_|   | |_ _ _ 
|   __|  _| | | |  _|_'_|
|__|  |_| |_|___|_| |_,_|
                        @mehedi1194

Get endpoints from #AlienVault
Open_Threat_Exchange for fun & profit
                         
${STOP}"

#Additional_Info
type -P gron &>/dev/null && echo -e "${Gcyan}[*] Gron   YES ]${STOP}" || { echo -e "${Gcyan}[*] Gron    NO ]${STOP}";exit; }
echo -e "${Gcyan}[*] Domain   $(cat $1 | wc -l) ]${Cyan}"
echo " "

#Main_Loop
for target in $(cat $1);do
echo -e "${DO}===============================||||||||||==================================${STOP}"
echo " "
echo -e "${Gcyan}[*] Checking urls of [ $target ]${STOP}"
echo " "
gron "https://otx.alienvault.com/otxapi/indicator/hostname/url_list/$target?limit=100&page=1" | grep "\burl\b" | gron --ungron | jq | grep '\"url\"' | awk -F "\"" '{print $4}' | tee -a allurl.txt 
echo " "
echo -e "${DO}===============================||||||||||==================================${STOP}"
done

#End
echo " "
echo -e "${Gcyan}[*] Total Url Found  [ $(cat allurl.txt | sort -u | wc -l) ] ${STOP}"
echo -e "${Gcyan}[*] I am done here  ${STOP}"
echo -e "${Gcyan}[*] Let's see what you get next ;)  ${STOP}"

#Sanitize
cat allurl.txt | sort -u > urls.txt
rm allurl.txt
