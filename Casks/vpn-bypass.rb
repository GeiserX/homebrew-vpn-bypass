cask "vpn-bypass" do
  version "4.4.2"
  sha256 "144cc2eaf599f60b19c68ac14082cbee7f1696d917fdaf6f9297488b7663fb4d"

  url "https://github.com/GeiserX/VPN-Bypass/releases/download/v#{version}/VPN-Bypass-#{version}.dmg"
  name "VPN Bypass"
  desc "Menu bar app to route specific traffic around VPN"
  homepage "https://github.com/GeiserX/VPN-Bypass"

  depends_on macos: :ventura

  app "VPN Bypass.app"
  binary "#{appdir}/VPN Bypass.app/Contents/MacOS/vpnb"

  preflight do
    system_command "/usr/bin/pkill",
                   args:         ["-x", "VPNBypass"],
                   sudo:         false,
                   must_succeed: false
  end

  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-cr", "#{appdir}/VPN Bypass.app"],
                   sudo: false

    system_command "/usr/bin/codesign",
                   args: ["--force", "--deep", "--sign", "-", "#{appdir}/VPN Bypass.app"],
                   sudo: false

    system_command "/usr/bin/open",
                   args:         ["#{appdir}/VPN Bypass.app"],
                   sudo:         false,
                   must_succeed: false
  end

  zap trash: [
    "~/Library/Application Support/VPNBypass",
    "~/Library/Caches/com.geiserx.vpn-bypass",
    "~/Library/Preferences/com.geiserx.vpn-bypass.plist",
  ]
end
