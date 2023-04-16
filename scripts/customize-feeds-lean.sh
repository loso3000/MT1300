cd /workdir
mkdir -p /workdir/openwrt/package/lean

# Add luci-app-ssr-plus
cd /workdir/openwrt/package/lean
git clone --depth=1 https://github.com/fw876/helloworld
cd /workdir/openwrt

# Clone community packages to package/community
mkdir package/community
cd /workdir/openwrt/package/community

# Add Lienol's Packages
git clone --depth=1 https://github.com/Lienol/openwrt-package

# Add luci-app-passwall
git clone --depth=1 https://github.com/xiaorouji/openwrt-passwall

