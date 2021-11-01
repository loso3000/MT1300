#!/bin/bash

# Add luci-app-ssr-plus
git clone --depth=1 https://github.com/fw876/helloworld ./package/ssr

# Add sirpdboy's Packages
git clone --depth=1 https://github.com/sirpdboy/sirpdboy-package  ./package/diy

# Add luci-app-passwall
git clone --depth=1 https://github.com/xiaorouji/openwrt-passwall  ./package/pass

# Add OpenClash
git clone --depth=1 -b master https://github.com/vernesong/OpenClash  ./package/clash

# Add gotop
svn co https://github.com/project-openwrt/openwrt/trunk/package/ctcgfw/gotop  ./package/gotop

# Add smartdns
svn co https://github.com/pymumu/smartdns/trunk/package/openwrt ./package/smartdns
svn co https://github.com/project-openwrt/openwrt/trunk/package/ntlf9t/luci-app-smartdns ./package/luci-app-smartdns

# Fix mt76 wireless driver
#cd  /workdir/openwrt/package/kernel/mt76
#rm -f Makefile
#wget https://raw.githubusercontent.com/openwrt/openwrt/master/package/kernel/mt76/Makefile
#sed -i '/mt7662u_rom_patch.bin/a\\techo mt76-usb disable_usb_sg=1 > $\(1\)\/etc\/modules.d\/mt76-usb' Makefile
