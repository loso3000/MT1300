cd /workdir
mkdir -p /workdir/openwrt/package/lean

# Add luci-app-ssr-plus
cd /workdir/openwrt/package/lean
git clone --depth=1 https://github.com/fw876/helloworld

cd /workdir/openwrt
cd /workdir/lede/package/lean
plist="shadowsocksr-libev pdnsd-alt microsocks dns2socks simple-obfs v2ray-plugin v2ray xray trojan ipt2socks redsocks2 kcptun luci-app-zerotier"
for dir in $plist
do
    if [ -d $dir ]
    then
        echo "Copying plugin $dir to /workdir/openwrt/package/lean ..."
        cp -rp $dir /workdir/openwrt/package/lean/
    else
        echo "$dir does not exists..."
    fi
done

cd /workdir/openwrt
[ -d /workdir/openwrt/feeds/gli_pub/shadowsocks-libev ] && mv /workdir/openwrt/feeds/gli_pub/shadowsocks-libev /workdir/openwrt/feeds/gli_pub/shadowsocks-libev.bak
if [ -d /workdir/lede/feeds/packages/net/shadowsocks-libev ]
then
    [ -d /workdir/openwrt/feeds/packages/net/shadowsocks-libev ] && mv /workdir/openwrt/feeds/packages/net/shadowsocks-libev /workdir/openwrt/feeds/packages/net/shadowsocks-libev.bak
    [ -d /workdir/openwrt/feeds/gli_pub ] && cp -r /workdir/lede/feeds/packages/net/shadowsocks-libev /workdir/openwrt/feeds/gli_pub/shadowsocks-libev
    [ -d /workdir/openwrt/package/lean/helloworld ] && cp -r /workdir/lede/feeds/packages/net/shadowsocks-libev /workdir/openwrt/package/lean/helloworld/
    cp -r /workdir/lede/feeds/packages/net/shadowsocks-libev /workdir/openwrt/feeds/packages/net/shadowsocks-libev
fi

rm -rf /workdir/openwrt/feeds/packages/net/wget
cp -rp /workdir/lede/package/lean/wget /workdir/openwrt/feeds/packages/net/wget
cp -rp /workdir/lede/package/lean/wget /workdir/openwrt/package/lean/wget

cd /workdir/openwrt
#add sirpdboy
svn co https://github.com/sirpdboy/sirpdboy-package/trunk/luci-app-advanced ./package/new/luci-app-advanced
svn co https://github.com/sirpdboy/sirpdboy-package/trunk/luci-app-netspeedtest ./package/new/luci-app-netspeedtest
svn co https://github.com/sirpdboy/sirpdboy-package/trunk/luci-app-autotimeset ./package/new/luci-app-autotimeset
svn co https://github.com/jerrykuku/luci-app-vssr/trunk/  package/new/luci-app-vssr

# Clone community packages to package/community
mkdir package/community
cd /workdir/openwrt/package/community

# Add Lienol's Packages
git clone --depth=1 https://github.com/Lienol/openwrt-package

# Add luci-app-passwall
git clone --depth=1 https://github.com/xiaorouji/openwrt-passwall
# Add gotop
svn co https://github.com/project-openwrt/openwrt/trunk/package/ctcgfw/gotop


# Add adbyby
cp -r /workdir/lede/package/lean/adbyby ./
cp -r /workdir/lede/package/lean/luci-app-adbyby-plus ./

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
