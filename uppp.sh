### PKCON
# echo -e "-----------------> sudo pkcon refresh -y"
# sudo pkcon refresh -y
# 
# echo -e "-----------------> pkcon get-updates"
# pkcon get-updates 2>&1 | tee .uppp.sh.log
# 
# echo -e "-----------------> sudo pkcon update -y"
# sudo pkcon update -y
# 
# echo -e "-----------------> sudo apt autoremove -y"
# sudo apt autoremove -y
# 
# echo -e "-----------------> sudo apt autoclean -y"
# sudo apt autoclean -y

### APTITUDE
echo -e "-----------------> sudo aptitude update -y"
sudo aptitude update -y

echo -e "-----------------> apt list --upgradable"
apt list --upgradable 2>&1 | tee .uppp.sh.log

echo -e "-----------------> sudo aptitude upgrade -y"
sudo aptitude upgrade -y

echo -e "-----------------> sudo aptitude autoclean -y"
sudo aptitude autoclean -y
