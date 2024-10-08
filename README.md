# Actions-OpenWrt

Build OpenWrt and publish docker image using GitHub Actions

Credit to ***P3TERX***, ***bin20088*** and ***flippy***，this is just a combination of their work.

The firmwares released are for S9xxx devices, Newifi_D2, G-Dock, amd64 and the J4125 with rtl8125 ethernet device.

Feel free to [fork](https://github.com/HoldOnBro/Actions-OpenWrt/generate) or just pull [my docker image](https://hub.docker.com/r/minirailgun/openwrt-aarch64/tags) to save time, it will be updated everyday.

## How to Use

You need to add 5(at least the first one) secrets to make Actions work properly.

1. **RELEASES_TOKEN**, which should be your Github **Personal Access Token** with at least the *public_repo* checked.
2. **DOCKER_USERNAME**(Optional, if you don't need an aarch64 docker img) is your dockerhub username.
3. **DOCKER_PASSWORD**(Optional, if you don't need an aarch64 docker img) , which is actually not the password for your dockerhub account but the **Access Token** generated from dockerhub Account Settings.
4. **Telegram notify secrets**(Optional, but remember to comment out relational action in ymls) , **TELEGRAM_TOKEN** for your bot token and **TELEGRAM_TO** for your personal id. [click here for more information](https://github.com/marketplace/actions/telegram-notify)

[P3TERX大佬写的中文教程|Usage Guide in Chinese](https://p3terx.com/archives/build-openwrt-with-github-actions.html)
## Acknowledgments

- [P3TERX/Actions-OpenWrt](https://github.com/P3TERX/Actions-OpenWrt)
- [bin20088/Bin](https://github.com/bin20088/Bin)
- [Microsoft](https://www.microsoft.com)
- [Microsoft Azure](https://azure.microsoft.com)
- [GitHub](https://github.com)
- [GitHub Actions](https://github.com/features/actions)
- [tmate](https://github.com/tmate-io/tmate)
- [mxschmitt/action-tmate](https://github.com/mxschmitt/action-tmate)
- [csexton/debugger-action](https://github.com/csexton/debugger-action)
- [Cisco](https://www.cisco.com/)
- [OpenWrt](https://github.com/openwrt/openwrt)
- [Lean's OpenWrt](https://github.com/coolsnowwolf/lede)
- [Cowtransfer](https://cowtransfer.com)
- [WeTransfer](https://wetransfer.com/)
- [Mikubill/transfer](https://github.com/Mikubill/transfer)
