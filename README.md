<p align="center"><img src="docs/images/banner.svg" alt="homebrew-vpn-bypass banner" width="900"/></p>

<h1 align="center">homebrew-vpn-bypass</h1>

Homebrew tap for [VPN Bypass](https://github.com/GeiserX/VPN-Bypass), the macOS menu bar app that routes chosen domains and services around your VPN. Releases and issues live in the [VPN Bypass repository](https://github.com/GeiserX/VPN-Bypass).

## Quick start

```bash
brew tap geiserx/vpn-bypass
brew trust --cask geiserx/vpn-bypass/vpn-bypass   # Homebrew 6+ blocks the install without it
brew install --cask vpn-bypass
open -a "VPN Bypass"
```

Needs macOS 13 or later. Uninstall with `brew uninstall --cask vpn-bypass`.

## License

[GPL-3.0-or-later](LICENSE)
