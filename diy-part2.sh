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
#sed -i 's/192.168.1.1/192.168.0.1/g' package/base-files/files/bin/config_generate
#sed -i 's/KERNEL_PATCHVER:=5.15/KERNEL_PATCHVER:=5.4/g' ./target/linux/x86/Makefile

function merge_package() {
    # 参数1是分支名,参数2是库地址,参数3是所有文件下载到指定路径。
    # 同一个仓库下载多个文件夹直接在后面跟文件名或路径，空格分开。
    if [[ $# -lt 3 ]]; then
        echo "Syntax error: [$#] [$*]" >&2
        return 1
    fi
    trap 'rm -rf "$tmpdir"' EXIT
    branch="$1" curl="$2" target_dir="$3" && shift 3
    rootdir="$PWD"
    localdir="$target_dir"
    [ -d "$localdir" ] || mkdir -p "$localdir"
    tmpdir="$(mktemp -d)" || exit 1
    git clone -b "$branch" --depth 1 --filter=blob:none --sparse "$curl" "$tmpdir"
    cd "$tmpdir"
    git sparse-checkout init --cone
    git sparse-checkout set "$@"
    # 使用循环逐个移动文件夹
    for folder in "$@"; do
        mv -f "$folder" "$rootdir/$localdir"
    done
    cd "$rootdir"
}

# 删除软件包
rm -rf feeds/luci/themes/luci-theme-argon
rm -rf feeds/luci/applications/luci-app-mosdns
rm -rf feeds/packages/net/{alist,adguardhome,mosdns,xray*,v2ray*,v2ray*,sing*,smartdns}
rm -rf feeds/packages/utils/v2dat
rm -rf feeds/packages/lang/golang
merge_package master https://github.com/kenzok8/small package/v2raya v2raya
merge_package main https://github.com/xiaorouji/openwrt-passwall-packages package/geoview geoview

git clone https://github.com/kenzok8/golang feeds/packages/lang/golang

# readd cpufreq for aarch64 & Change to system
#sed -i 's/LUCI_DEPENDS.*/LUCI_DEPENDS:=\@\(arm\|\|aarch64\)/g' package/feeds/luci/luci-app-cpufreq/Makefile
#sed -i 's/services/system/g'  package/feeds/luci/luci-app-cpufreq/luasrc/controller/cpufreq.lua
# autocore
#sed -i 's/DEPENDS:=@(.*/DEPENDS:=@(TARGET_bcm27xx||TARGET_bcm53xx||TARGET_ipq40xx||TARGET_ipq806x||TARGET_ipq807x||TARGET_mvebu||TARGET_rockchip||TARGET_armvirt) \\/g' package/lean/autocore/Makefile
# 修改应用位置
#sed -i 's/services/vpn/g' feeds/luci/applications/luci-app-ocserv/luasrc/controller/ocserv.lua #OpenConnect VPN-->VPN
#sed -i 's/services/vpn/g' feeds/luci/applications/luci-app-openvpn/luasrc/controller/openvpn.lua
# sed -i 's/services/vpn/g' package/feeds/luci/luci-app-v2ray-server/luasrc/controller/v2ray_server.lua
#sed -i 's/services/vpn/g'  feeds/luci/applications/luci-app-openvpn/luasrc/model/cbi/openvpn.lua
#sed -i 's/services/vpn/g'  feeds/luci/applications/luci-app-openvpn/luasrc/view/openvpn/pageswitch.htm
# openssh
# sed -i '175i\	--with-sandbox=rlimit \\' feeds/packages/net/openssh/Makefile


#添加额外软件包
merge_package main https://github.com/xiaorouji/openwrt-passwall package/passwall luci-app-passwall
merge_package main https://github.com/xiaorouji/openwrt-passwall2 package/passwall luci-app-passwall2
merge_package main https://github.com/xiaorouji/openwrt-passwall-packages package/passwall brook chinadns-ng dns2socks dns2tcp gn hysteria ipt2socks microsocks naiveproxy pdnsd-alt shadowsocks-rust shadowsocksr-libev simple-obfs sing-box ssocks tcping trojan-go trojan-plus trojan tuic-client v2ray-core v2ray-geodata v2ray-plugin xray-core xray-plugin
merge_package dev  https://github.com/vernesong/OpenClash package/openclash luci-app-openclash
merge_package master https://github.com/kenzok8/small package/ssr-plus luci-app-ssr-plus lua-neturl shadow-tls redsocks2 v2dat mosdns
merge_package master https://github.com/kenzok8/openwrt-packages package/kenzok8 alist adguardhome smartdns

# 编译 po2lmo (如果有po2lmo可跳过)
pushd package/openclash/luci-app-openclash/tools/po2lmo
make && sudo make install
popd

# 主题
git clone https://github.com/SAENE/luci-theme-design package/theme
#merge_package master https://github.com/1234684/Actions-OpenWrt package/theme packages/luci-app-argon-config packages/luci-theme-argon packages/luci-theme-opentomcat packages/luci-theme-ifit

#git clone https://github.com/jerrykuku/luci-app-argon-config package/luci-app-argon-config
#git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon package/luci-theme-argon
#svn co https://github.com/kenzok8/openwrt-packages/trunk/luci-theme-atmaterial_new package/luci-theme-atmaterial_new
#svn co https://github.com/kenzok8/openwrt-packages/trunk/luci-theme-edge package/luci-theme-edge
#svn co https://github.com/kenzok8/openwrt-packages/trunk/luci-theme-ifit package/luci-theme-ifit
#svn co https://github.com/kenzok8/openwrt-packages/trunk/luci-theme-mcat package/luci-theme-mcat
#svn co https://github.com/kenzok8/openwrt-packages/trunk/luci-theme-tomato package/luci-theme-tomato
#svn co https://github.com/kenzok8/openwrt-packages/trunk/luci-theme-ifit package/luci-theme-ifit
#svn co https://github.com/sirpdboy/luci-theme-opentopd/trunk package/luci-theme-opentopd
#svn co https://github.com/apollo-ng/luci-theme-darkmatter/trunk/luci/themes/luci-theme-darkmatter package/luci-theme-darkmatter
#svn co https://github.com/rosywrt/luci-theme-rosy/trunk/luci-theme-rosy package/luci-theme-rosy
#svn co https://github.com/thinktip/luci-theme-neobird/trunk package/luci-theme-neobird
#svn co https://github.com/haiibo/packages/trunk/luci-theme-opentomato package/luci-theme-opentomato
#svn co https://github.com/haiibo/packages/trunk/luci-theme-opentomcat package/luci-theme-opentomcat
#svn co https://github.com/haiibo/packages/trunk/luci-theme-infinityfreedom package/luci-theme-infinityfreedom

#luci-app-amlogic
merge_package main https://github.com/ophub/luci-app-amlogic package luci-app-amlogic


./scripts/feeds update -a
./scripts/feeds install -a
