cask "vpn-bypass" do
  version "5.2.0"
  sha256 "0e6fa954095dee67e2350ef71698f41f0aaafeb48488a071f77b7ab61c785283"

  url "https://github.com/GeiserX/VPN-Bypass/releases/download/v#{version}/VPN-Bypass-#{version}.dmg"
  name "VPN Bypass"
  desc "Menu bar app to route specific traffic around VPN"
  homepage "https://github.com/GeiserX/VPN-Bypass"

  depends_on macos: :ventura

  app "VPN Bypass.app"
  binary "#{appdir}/VPN Bypass.app/Contents/MacOS/vpnb"

  zap trash: [
    "~/Library/Application Support/VPNBypass",
    "~/Library/Caches/com.geiserx.vpn-bypass",
    "~/Library/Preferences/com.geiserx.vpn-bypass.plist",
  ]
end
