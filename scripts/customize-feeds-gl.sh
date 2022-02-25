cd /workdir
mkdir -p /workdir/openwrt/package/lean

git clone --depth=1 https://github.com/fw876/helloworld package/ssr

cd /workdir/openwrt
cd /workdir/lede/feeds/packages/net/
plist="redsocks2 tcpping luci-app-zerotier"
for dir in $plist
do
    if [ -d $dir ]
    then
        echo "Copying plugin $dir to /workdir/openwrt/package/lean ..."
        cp -rp $dir /workdir/openwrt/feeds/packages/net/
    else
        echo "$dir does not exists..."
    fi
done

cd /workdir/openwrt
[ -d /workdir/openwrt/feeds/gli_pub/shadowsocks-libev ] && rm -rf /workdir/openwrt/feeds/gli_pub/shadowsocks-libev  # /workdir/openwrt/feeds/gli_pub/shadowsocks-libev.bak
if [ -d /workdir/lede/feeds/packages/net/shadowsocks-libev ]
then
    [ -d /workdir/openwrt/feeds/packages/net/shadowsocks-libev ] && rm -rf /workdir/openwrt/feeds/packages/net/shadowsocks-libev # /workdir/openwrt/feeds/packages/net/shadowsocks-libev.bak
    [ -d /workdir/openwrt/feeds/gli_pub ] && cp -r /workdir/lede/feeds/packages/net/shadowsocks-libev /workdir/openwrt/feeds/gli_pub/shadowsocks-libev
    [ -d /workdir/openwrt/package/lean/helloworld ] && cp -r /workdir/lede/feeds/packages/net/shadowsocks-libev /workdir/openwrt/package/lean/helloworld/
    cp -r /workdir/lede/feeds/packages/net/shadowsocks-libev /workdir/openwrt/feeds/packages/net/shadowsocks-libev
fi

rm -rf /workdir/openwrt/feeds/packages/net/wget 
mkdir /workdir/openwrt/feeds/packages/net/wget -p
cp -rp /workdir/lede/feeds/packages/net/wget /workdir/openwrt/feeds/packages/net/wget
#cp -rp /workdir/lede/feeds/packages/net/wget /workdir/openwrt/package/lean/wget

# R8168驱动
# git clone -b master --depth 1 https://github.com/BROBIRD/openwrt-r8168.git package/new/r8168
svn co https://github.com/immortalwrt/immortalwrt/branches/master/package/kernel/r8168 package/new/r8168
# patch -p1 <../PATCH/r8168/r8168-fix_LAN_led-for_r4s-from_TL.patch
# R8125驱动
svn co https://github.com/immortalwrt/immortalwrt/branches/master/package/kernel/r8125 package/new/r8125
# R8152驱动
svn co https://github.com/immortalwrt/immortalwrt/branches/master/package/kernel/r8152 package/new/r8152
cd /workdir/openwrt
#add sirpdboy
# svn co https://github.com/sirpdboy/sirpdboy-package/trunk/luci-app-advanced ./package/new/luci-app-advanced
# svn co https://github.com/sirpdboy/sirpdboy-package/trunk/luci-app-netspeedtest ./package/new/luci-app-netspeedtest
# svn co https://github.com/sirpdboy/sirpdboy-package/trunk/luci-app-autotimeset ./package/new/luci-app-autotimeset
svn co https://github.com/jerrykuku/luci-app-vssr/trunk/  package/new/luci-app-vssr
svn co https://github.com/sirpdboy/sirpdboy-package/trunk/lua-maxminddb ./package/new/lua-maxminddb
svn co https://github.com/sirpdboy/sirpdboy-package/trunk/AdGuardHome ./package/new/AdGuardHome
svn co https://github.com/sirpdboy/sirpdboy-package/trunk/luci-app-adguardhome ./package/new/luci-app-adguardhome
git clone https://github.com/garypang13/luci-app-dnsfilter.git package/luci-app-dnsfilter

svn co https://github.com/sirpdboy/build/trunk/automount ./package/new/automount
svn co https://github.com/sirpdboy/build/trunk/autosamba ./package/new/autosamba

rm -rf ./feeds/luci/applications/luci-app-samba
svn co https://github.com/sirpdboy/build/trunk/luci-app-samba ./feeds/luci/applications/luci-app-samba
rm -rf ./package/network/services/samba36 
svn co https://github.com/sirpdboy/build/trunk/samba36 ./package/network/services/samba36
rm -rf ./feeds/package/net/samba4 && svn co https://github.com/sirpdboy/build/trunk/samba4 ./feeds/packages/net/samba4
rm -rf ./feeds/luci/applications/luci-app-samba4
svn co https://github.com/sirpdboy/build/trunk/luci-app-samba4 ./feeds/luci/applications/luci-app-samba4

# Clone community packages to package/community
# mkdir package/community
# cd /workdir/openwrt/package/community

# Add Lienol's Packages
# git clone --depth=1 https://github.com/Lienol/openwrt-package  /workdir/openwrt/package/new/

# Add luci-app-passwall
git clone --depth=1 https://github.com/xiaorouji/openwrt-passwall  /workdir/openwrt/package/new/passwall
# Add gotop
svn co https://github.com/project-openwrt/openwrt/trunk/package/ctcgfw/gotop /workdir/openwrt/package/new/gotop

git clone https://github.com/sirpdboy/build.git ./package/build


svn co https://github.com/vernesong/OpenClash/trunk/luci-app-openclash ./package/diy/luci-app-openclash
# Add openclash
# git clone --depth=1 -b master https://github.com/vernesong/OpenClash
# ARCH=mipsle-hardfloat
# cd /workdir/openwrt
# mkdir -p files/etc/openclash/core
# cd files/etc/openclash/core

# clash_main_url=$(curl -sL https://api.github.com/repos/vernesong/OpenClash/releases/tags/Clash | grep /clash-linux-$ARCH | sed 's/.*url\": \"//g' | sed 's/\"//g')
#clash_tun_url=$(curl -sL https://api.github.com/repos/vernesong/OpenClash/releases/tags/TUN-Premium | grep /clash-linux-$ARCH | sed 's/.*url\": \"//g' | sed 's/\"//g')
#clash_game_url=$(curl -sL https://api.github.com/repos/vernesong/OpenClash/releases/tags/TUN | grep /clash-linux-$ARCH | sed 's/.*url\": \"//g' | sed 's/\"//g')

# wget $clash_main_url && tar zxvf clash-linux-*.gz && rm -f clash-linux-*.gz
#wget -qO- $clash_main_url | gunzip -c > clash
#wget -qO- $clash_tun_url  | gunzip -c > clash_tun
#wget -qO- $clash_game_url | tar xOvz > clash_game

# chmod +x clash*

mkdir /workdir/openwrt/package/lean/redsocks2 
cd /workdir/openwrt/feeds/packages/net/
wget https://github.com/coolsnowwolf/lede/blob/master/package/lean/redsocks2/Makefile
