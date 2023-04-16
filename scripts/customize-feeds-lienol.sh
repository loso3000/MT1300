mkdir -p /workdir/openwrt/package/lean
cd /workdir/openwrt/package/lean
git clone --depth=1 https://github.com/fw876/helloworld
git clone --depth=1 https://github.com/xiaorouji/openwrt-passwall
svn co https://github.com/pymumu/smartdns/trunk/package/openwrt smartdns
svn co https://github.com/project-openwrt/openwrt/trunk/package/ntlf9t/luci-app-smartdns

# Add openclash
git clone --depth=1 -b master https://github.com/vernesong/OpenClash
ARCH=mipsle-hardfloat
cd /workdir/openwrt
mkdir -p files/etc/openclash/core
cd files/etc/openclash/core

clash_main_url=$(curl -sL https://api.github.com/repos/vernesong/OpenClash/releases/tags/Clash | grep /clash-linux-$ARCH | sed 's/.*url\": \"//g' | sed 's/\"//g')
#clash_tun_url=$(curl -sL https://api.github.com/repos/vernesong/OpenClash/releases/tags/TUN-Premium | grep /clash-linux-$ARCH | sed 's/.*url\": \"//g' | sed 's/\"//g')
#clash_game_url=$(curl -sL https://api.github.com/repos/vernesong/OpenClash/releases/tags/TUN | grep /clash-linux-$ARCH | sed 's/.*url\": \"//g' | sed 's/\"//g')

wget $clash_main_url && tar zxvf clash-linux-*.gz && rm -f clash-linux-*.gz
#wget -qO- $clash_main_url | gunzip -c > clash
#wget -qO- $clash_tun_url  | gunzip -c > clash_tun
#wget -qO- $clash_game_url | tar xOvz > clash_game

chmod +x clash*


mkdir /workdir/openwrt/package/lean/redsocks2 
cd /workdir/openwrt/package/lean/redsocks2 
wget https://github.com/coolsnowwolf/lede/blob/master/package/lean/redsocks2/Makefile
