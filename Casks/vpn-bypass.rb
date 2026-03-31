cask "vpn-bypass" do
  version "2.1.1"
  sha256 "2bcc478a769e8e5b8e9ebce95dc40a7b46785f58d9b8c99516fcfd3f7f14ef52"

  url "https://github.com/GeiserX/VPN-Bypass/releases/download/v#{version}/VPN-Bypass-#{version}.dmg"
  name "VPN Bypass"
  desc "macOS menu bar app to route specific traffic around VPN"
  homepage "https://github.com/GeiserX/VPN-Bypass"

  depends_on macos: ">= :ventura"

  app "VPN Bypass.app"

  preflight do
    system_command "/usr/bin/pkill",
                   args: ["-x", "VPNBypass"],
                   sudo: false,
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
                   args: ["#{appdir}/VPN Bypass.app"],
                   sudo: false,
                   must_succeed: false
  end

  zap trash: [
    "~/Library/Application Support/VPNBypass",
    "~/Library/Preferences/com.geiserx.vpn-bypass.plist",
    "~/Library/Caches/com.geiserx.vpn-bypass",
  ]
end
