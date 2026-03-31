# Homebrew Cask for VPN Bypass
# Install: brew install --cask geiserx/tap/vpn-bypass

cask "vpn-bypass" do
  version "2.1.1"
  sha256 "95f22ffa89d2563a4ebd3818bdc5b1d764187b9c5f51f4f818c149e5fdf85e7f"

  url "https://github.com/GeiserX/VPN-Bypass/releases/download/v#{version}/VPN-Bypass-#{version}.dmg"
  name "VPN Bypass"
  desc "macOS menu bar app to route specific traffic around VPN"
  homepage "https://github.com/GeiserX/VPN-Bypass"

  depends_on macos: ">= :ventura"

  app "VPN Bypass.app"

  preflight do
    # Quit running app before upgrade so the new binary takes effect
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
