# Install configuration
```
cd ~
su
apt install vim git -y
git clone https://github.com/aisk11/debian
cd ./debian/install/
```
Change variables in ***install.sh*** script.
```
bash install.sh | tee -a /root/install-output.txt
```
