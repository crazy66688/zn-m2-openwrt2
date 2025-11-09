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
#优先安装 passwall 源
./scripts/feeds install -a -f -p passwall_packages
./scripts/feeds install -a -f -p passwall_luci
git clone --depth=1 https://github.com/nikkinikki-org/OpenWrt-nikki package/nikki
git clone https://github.com/sirpdboy/luci-app-lucky.git package/lucky
git clone https://github.com/sirpdboy/luci-app-timecontrol package/luci-app-timecontrol
git clone https://github.com/zzsj0928/luci-app-pushbot package/luci-app-pushbot

# Git稀疏克隆，只克隆指定目录到本地
function git_sparse_clone() {
  branch="$1" repourl="$2" && shift 2
  git clone --depth=1 -b $branch --single-branch --filter=blob:none --sparse $repourl
  repodir=$(echo $repourl | awk -F '/' '{print $(NF)}')
  cd $repodir && git sparse-checkout set $@
  mv -f $@ ../package
  cd .. && rm -rf $repodir
}
git_sparse_clone master https://github.com/vernesong/OpenClash package/luci-app-openclash
