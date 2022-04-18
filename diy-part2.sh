#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#


# Modify default IP
sed -i 's/192.168.1.1/192.168.0.1/g' package/base-files/files/bin/config_generate
# 删除软件包
rm -rf feeds/luci/themes/luci-theme-argon
rm -rf feeds/luci/applications/luci-app-pptp-server
#rm -rf feeds/luci/applications/luci-app-netdata
rm -rf feeds/packages/multimedia/UnblockNeteaseMusic
rm -rf feeds/luci/applications/luci-app-unblockmusic

# readd cpufreq for aarch64 & Change to system
sed -i 's/LUCI_DEPENDS.*/LUCI_DEPENDS:=\@\(arm\|\|aarch64\)/g' package/feeds/luci/luci-app-cpufreq/Makefile
sed -i 's/services/system/g'  package/feeds/luci/luci-app-cpufreq/luasrc/controller/cpufreq.lua
# autocore
sed -i 's/DEPENDS:=@(.*/DEPENDS:=@(TARGET_bcm27xx||TARGET_bcm53xx||TARGET_ipq40xx||TARGET_ipq806x||TARGET_ipq807x||TARGET_mvebu||TARGET_rockchip||TARGET_armvirt) \\/g' package/lean/autocore/Makefile
# 修改应用位置
sed -i 's/services/vpn/g' feeds/luci/applications/luci-app-ocserv/luasrc/controller/ocserv.lua #OpenConnect VPN-->VPN
sed -i 's/services/vpn/g' feeds/luci/applications/luci-app-openvpn/luasrc/controller/openvpn.lua
# sed -i 's/services/vpn/g' package/feeds/luci/luci-app-v2ray-server/luasrc/controller/v2ray_server.lua
sed -i 's/services/vpn/g'  feeds/luci/applications/luci-app-openvpn/luasrc/model/cbi/openvpn.lua
sed -i 's/services/vpn/g'  feeds/luci/applications/luci-app-openvpn/luasrc/view/openvpn/pageswitch.htm
# openssh
# sed -i '175i\	--with-sandbox=rlimit \\' feeds/packages/net/openssh/Makefile


#添加额外软件包
# git clone https://github.com/sirpdboy/luci-app-netdata package/luci-app-netdata
svn co https://github.com/jerrykuku/lua-maxminddb/trunk package/lua-maxminddb
svn co https://github.com/jerrykuku/luci-app-vssr/trunk package/luci-app-vssr
svn co https://github.com/vernesong/OpenClash/trunk/luci-app-openclash package/luci-app-openclash
svn co https://github.com/iwrt/luci-app-ikoolproxy/trunk package/luci-app-ikoolproxy
svn co https://github.com/ophub/luci-app-amlogic/trunk/luci-app-amlogic package/luci-app-amlogic
svn co https://github.com/Lienol/openwrt-package/trunk/luci-app-socat package/luci-app-socat
svn co https://github.com/Lienol/openwrt-package/trunk/luci-app-pptp-server package/luci-app-pptp-server
svn co https://github.com/sundaqiang/openwrt-packages/trunk/luci-app-wolplus package/luci-app-wolplus

# 编译 po2lmo (如果有po2lmo可跳过)
pushd package/luci-app-openclash/tools/po2lmo
make && sudo make install
popd
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/brook package/brook
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/chinadns-ng package/chinadns-ng
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/tcping package/tcping
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/trojan-go package/trojan-go
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/trojan-plus package/trojan-plus
#svn co https://github.com/xiaorouji/openwrt-passwall/trunk/luci-app-passwall package/luci-app-passwall
#svn co https://github.com/breakings/OpenWrt/trunk/general/luci-app-passwall package/luci-app-passwall
svn co https://github.com/xiaorouji/openwrt-passwall/branches/luci/luci-app-passwall package/luci-app-passwall

svn co https://github.com/xiaorouji/openwrt-passwall/trunk/shadowsocks-rust package/shadowsocks-rust
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/xray-core package/xray-core
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/xray-plugin package/xray-plugin
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/ssocks package/ssocks
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/dns2socks package/dns2socks
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/ipt2socks package/ipt2socks
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/microsocks package/microsocks 
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/pdnsd-alt package/pdnsd-alt
svn co https://github.com/fw876/helloworld/trunk/shadowsocksr-libev package/shadowsocksr-libev
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/v2ray-core package/v2ray-core
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/v2ray-plugin package/v2ray-plugin
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/v2ray-geodata package/v2ray-geodata
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/simple-obfs package/simple-obfs
#svn co https://github.com/xiaorouji/openwrt-passwall/trunk/kcptun package/kcptun
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/trojan package/trojan
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/hysteria package/hysteria

svn co https://github.com/kenzok8/openwrt-packages/trunk/luci-app-gost package/luci-app-gost
svn co https://github.com/kenzok8/openwrt-packages/trunk/gost package/gost
svn co https://github.com/kenzok8/openwrt-packages/trunk/luci-app-eqos package/luci-app-eqos
svn co https://github.com/fw876/helloworld/trunk/luci-app-ssr-plus package/luci-app-ssr-plus
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/naiveproxy package/naiveproxy
git clone https://github.com/semigodking/redsocks.git package/redsocks2
svn co https://github.com/rufengsuixing/luci-app-adguardhome/trunk package/luci-app-adguardhome
svn co https://github.com/Lienol/openwrt-package/trunk/luci-app-filebrowser package/luci-app-filebrowser
svn co https://github.com/Lienol/openwrt-package/trunk/luci-app-ssr-mudb-server package/luci-app-ssr-mudb-server

#添加smartdns
svn co https://github.com/kenzok8/openwrt-packages/trunk/luci-app-smartdns package/luci-app-smartdns

#mosdns
#svn co https://github.com/QiuSimons/openwrt-mos/trunk/luci-app-mosdns package/luci-app-mosdns

# 主题
git clone https://github.com/jerrykuku/luci-app-argon-config package/luci-app-argon-config
git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon package/luci-theme-argon
#svn co https://github.com/kenzok8/openwrt-packages/trunk/luci-theme-atmaterial_new package/luci-theme-atmaterial_new
#svn co https://github.com/kenzok8/openwrt-packages/trunk/luci-theme-edge package/luci-theme-edge
#svn co https://github.com/kenzok8/openwrt-packages/trunk/luci-theme-ifit package/luci-theme-ifit
svn co https://github.com/Leo-Jo-My/luci-theme-opentomato/trunk package/luci-theme-opentomato
svn co https://github.com/Leo-Jo-My/luci-theme-opentomcat/trunk package/luci-theme-opentomcat
#svn co https://github.com/sirpdboy/luci-theme-opentopd/trunk package/luci-theme-opentopd
#svn co https://github.com/apollo-ng/luci-theme-darkmatter/trunk/luci/themes/luci-theme-darkmatter package/luci-theme-darkmatter
svn co https://github.com/rosywrt/luci-theme-rosy/trunk/luci-theme-rosy package/luci-theme-rosy
svn co https://github.com/thinktip/luci-theme-neobird/trunk package/luci-theme-neobird

# cp -f $GITHUB_WORKSPACE/general/651-rt2x00-driver-compile-with-kernel-5.15.patch package/kernel/mac80211/patches/rt2x00
#cp -f $GITHUB_WORKSPACE/general/fs.mk package/kernel/linux/modules
#cp -f $GITHUB_WORKSPACE/general/01-export-nfs_ssc.patch target/linux/generic/backport-5.15
# cp -f $GITHUB_WORKSPACE/general/003-add-module_supported_device-macro.patch target/linux/generic/backport-5.15
# fix amule
#sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=2.3.3/g' feeds/packages/net/amule/Makefile
#sed -i 's/PKG_HASH:=.*/PKG_HASH:=102c4cb3dd2858db06fff19c5e2d0b65c6731b366f45df2adcd40fd0cd0fec47/g' feeds/packages/net/amule/Makefile
#cp -f $GITHUB_WORKSPACE/general/0001-fix-API-mismatch-with-crypto-6.0.0.patch feeds/packages/net/amule/patches
#cp -f $GITHUB_WORKSPACE/general/0002-fix-byte-type-error.patch feeds/packages/net/amule/patches
#cp -f $GITHUB_WORKSPACE/general/0003-fix-set_terminate.patch feeds/packages/net/amule/patches

# fix expat
# sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=2.4.7/g' feeds/packages/libs/expat/Makefile
# sed -i 's/PKG_HASH:=.*/PKG_HASH:=9875621085300591f1e64c18fd3da3a0eeca4a74f884b9abac2758ad1bd07a7d/g' feeds/packages/libs/expat/Makefile
# 晶晨宝盒
sed -i "s|https://github.com/breakings/OpenWrt|https://github.com/1234684/Actions-OpenWrt|g" package/luci-app-amlogic/root/etc/config/amlogic
# 解锁网易云
git clone https://github.com/UnblockNeteaseMusic/luci-app-unblockneteasemusic.git package/luci-app-unblockneteasemusic
# node 
sed -i "s/PKG_VERSION:=v14.18.3/PKG_VERSION:=v14.19.1/g" feeds/packages/lang/node/Makefile
sed -i "s/PKG_HASH:=783ac443cd343dd6c68d2abcf7e59e7b978a6a428f6a6025f9b84918b769d608/PKG_HASH:=e1ae09dd861ab39af04483bb5c0fa54ddd82b6b15543be9a27ea6704a8ba9dd9/g" feeds/packages/lang/node/Makefile
#tailscale
sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=1.22.2/g' feeds/packages/net/tailscale/Makefile
sed -i 's/PKG_HASH:=.*/PKG_HASH:=3e7b5b8073a7b94d84ff6677a9f110070b808c8d35c5b7da0c6e6fe639444e58/g' feeds/packages/net/tailscale/Makefile
./scripts/feeds update -a
./scripts/feeds install -a
