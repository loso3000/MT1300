cd openwrt/bin/targets/*/*
mkdir plugin

# plugin list in ../../../packages/mipsel_24kc
pkglist="base/adbyby_*.ipk base/luci-app-adbyby-plus_*.ipk base/shadowsocksr-libev-*.ipk base/pdnsd-alt_*.ipk base/chinadns-ng_*.ipk base/microsocks_*.ipk base/dns2socks_*.ipk base/simple-obfs*.ipk base/tcping_*.ipk base/v2ray-plugin_*.ipk base/xray_*.ipk base/trojan*.ipk base/ipt2socks_*.ipk base/redsocks2_*.ipk base/luci-*-passwall*.ipk base/luci-*-ssr-plus*.ipk luci/luci-compat_*.ipk base/xray-core_*.ipk gli_pub/shadowsocks-libev-ss-*.ipk base/shadowsocksr-libev-ssr-*.ipk base/luci-app-openclash*.ipk"

for pkg in $pkglist
do
    file=../../../packages/mipsel_24kc/$pkg
    ls=`ls $file 2>/dev/null`
    if [ -z $ls ]
    then
        echo "$pkg does not exists."
    else
        echo "Copying $pkg to plugin..."
        cp -f $file ./plugin/
    fi
done


echo "Creating installation script for passwall"
cat << EOF > ./plugin/install-passwall.sh
opkg update
opkg install luci luci-i18n-base-zh-cn ttyd luci-app-ttyd luci-i18n-ttyd-zh-cn luci-compat luci-lib-ipkg wget htop
opkg install ./chinadns-ng_*.ipk
opkg install ./dns2socks_*.ipk
opkg install ./ipt2socks_*.ipk
opkg install ./microsocks_*.ipk
opkg install ./pdnsd-alt_*.ipk
opkg install ./shadowsocks-libev-ss-local_*.ipk
opkg install ./shadowsocks-libev-ss-redir_*.ipk
opkg install ./shadowsocksr-libev-ssr-local_*.ipk
opkg install ./shadowsocksr-libev-ssr-redir_*.ipk
opkg install ./simple-obfs*.ipk
opkg install ./tcping_*.ipk
opkg install ./trojan*.ipk
opkg install ./xray-core_*.ipk
opkg install ./luci-app-passwall_*.ipk
opkg install ./luci-i18n-passwall-zh-cn_*.ipk
EOF

chmod +x ./plugin/install-passwall.sh

echo "Creating installation script for ssr plus"
cat << EOF > ./plugin/install-ssrp.sh
opkg update
opkg install luci luci-i18n-base-zh-cn ttyd luci-app-ttyd luci-i18n-ttyd-zh-cn luci-compat luci-lib-ipkg wget htop
opkg install ./pdnsd-alt_*.ipk
opkg install ./microsocks_*.ipk
opkg install ./dns2socks_*.ipk
opkg install ./shadowsocksr-libev-ssr-local_*.ipk
opkg install ./simple-obfs*.ipk
opkg install ./tcping_*.ipk
opkg install ./ipt2socks_*.ipk
opkg install ./xray-core_*.ipk
opkg install ./trojan_*.ipk
opkg install ./shadowsocks-libev-ss-local_*.ipk
opkg install ./shadowsocks-libev-ss-server_*.ipk
opkg install ./shadowsocks-libev-ss-redir_*.ipk
opkg install ./shadowsocksr-libev-ssr-check_*.ipk
opkg install ./luci-app-ssr-plus_*.ipk
opkg install ./luci-i18n-ssr-plus-zh-cn_*.ipk
EOF

chmod +x ./plugin/install-ssrp.sh

echo "Creating installation script for openclash"
cat << EOF > ./plugin/install-openclash.sh

opkg update
opkg install luci luci-i18n-base-zh-cn luci-compat luci-lib-ipkg wget htop libcap ttyd luci-app-ttyd luci-i18n-ttyd-zh-cn

# install libcap-bin, will try to get latest version later
#https://downloads.openwrt.org/snapshots/packages/mipsel_24kc/base/
cd /tmp
wget --no-check-certificate https://downloads.openwrt.org/snapshots/packages/mipsel_24kc/base/libcap-bin_2.63-1_mipsel_24kc.ipk
opkg install /tmp/libcap-bin_*.ipk

# install luci-app-openclash, will try to get latest version later
#https://github.com/vernesong/OpenClash/releases
wget --no-check-certificate https://github.com/vernesong/OpenClash/releases/download/v0.45.16-beta/luci-app-openclash_0.45.16-beta_all.ipk
opkg install /tmp/luci-app-openclash_*.ipk

# install openclash core, this script will download latest version openclash core.
mkdir -p /etc/openclash/core/
cd /etc/openclash/core/
clash_main_url=$(curl -sL https://api.github.com/repos/vernesong/OpenClash/releases/tags/Clash | grep /clash-linux-mipsle-softfloat | sed 's/.*url\": \"//g' | sed 's/\"//g')
wget $clash_main_url && tar zxvf clash-linux-*.gz && rm -f clash-linux-*.gz
chmod +x clash*
EOF

chmod +x ./plugin/install-openclash.sh


echo "Creating installation script for adbyby"
cat << EOF > ./plugin/install-adbyby.sh
opkg update
opkg install luci luci-i18n-base-zh-cn ttyd luci-app-ttyd luci-i18n-ttyd-zh-cn luci-compat luci-lib-ipkg wget htop
opkg install ./adbyby_*.ipk
opkg install ./luci-app-adbyby-plus_*.ipk
EOF

chmod +x ./plugin/install-adbyby.sh


tar czvf mt1300-plugin.tar.gz ./plugin
rm -rf ./plugin
