# Homebrew Cask for VPN Bypass
# Install: brew install --cask geiserx/tap/vpn-bypass
# Or if using local tap: brew install --cask --no-quarantine ./Casks/vpn-bypass.rb

cask "vpn-bypass" do
  version "1.3.1"
  sha256 "b81ca1cdaf86577ca1e42c244e0087b3eaa1dbff7ddefd0d0e4c76b8fb75b472"

  url "https://github.com/GeiserX/VPNBypass/releases/download/v#{version}/VPNBypass-#{version}.dmg"
  name "VPN Bypass"
  desc "macOS menu bar app to route specific traffic around VPN"
  homepage "https://github.com/GeiserX/VPNBypass"

  depends_on macos: ">= :ventura"

  app "VPN Bypass.app"

  postflight do
    # Remove quarantine attribute to avoid Gatekeeper warning
    system_command "/usr/bin/xattr",
                   args: ["-cr", "#{appdir}/VPN Bypass.app"],
                   sudo: false
    
    # Sign the app after installation (ad-hoc) for notifications to work
    system_command "/usr/bin/codesign",
                   args: ["--force", "--deep", "--sign", "-", "#{appdir}/VPN Bypass.app"],
                   sudo: false
  end

  zap trash: [
    "~/Library/Application Support/VPNBypass",
    "~/Library/Preferences/com.geiserx.vpn-bypass.plist",
    "~/Library/Caches/com.geiserx.vpn-bypass",
  ]
end
