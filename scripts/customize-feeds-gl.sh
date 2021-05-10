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

# Clone community packages to package/community
mkdir package/community
cd /workdir/openwrt/package/community

# Add Lienol's Packages
git clone --depth=1 https://github.com/Lienol/openwrt-package

# Add luci-app-passwall
git clone --depth=1 https://github.com/xiaorouji/openwrt-passwall

#add sirpdboy
svn co https://github.com/sirpdboy/sirpdboy-package/trunk/luci-app-advanced ./package/new/luci-app-advanced
svn co https://github.com/sirpdboy/sirpdboy-package/trunk/luci-app-netspeedtest ./package/new/luci-app-netspeedtest
svn co https://github.com/sirpdboy/sirpdboy-package/trunk/luci-app-autotimeset ./package/new/luci-app-autotimeset
svn co https://github.com/jerrykuku/luci-app-vssr/trunk/  package/diy/luci-app-vssr

# add openclash
svn co https://github.com/vernesong/OpenClash/trunk/luci-app-openclash package/diy/luci-app-openclash

# Add gotop
svn co https://github.com/project-openwrt/openwrt/trunk/package/ctcgfw/gotop

# Add smartdns
svn co https://github.com/pymumu/smartdns/trunk/package/openwrt ../smartdns
svn co https://github.com/project-openwrt/openwrt/trunk/package/ntlf9t/luci-app-smartdns ../luci-app-smartdns

# Add adbyby
cp -r /workdir/lede/package/lean/adbyby ./
cp -r /workdir/lede/package/lean/luci-app-adbyby-plus ./
