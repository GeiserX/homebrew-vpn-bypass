cask "vpn-bypass" do
  version "5.1.3"
  sha256 "cc7443b6e8f4071d97243f07cd2b84b96f73994ad028ca3c7561b61062d03421"

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
