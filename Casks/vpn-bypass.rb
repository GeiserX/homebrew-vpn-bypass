# Homebrew Cask for VPN Bypass
# Install: brew install --cask geiserx/tap/vpn-bypass
# Or if using local tap: brew install --cask --no-quarantine ./Casks/vpn-bypass.rb

cask "vpn-bypass" do
  version "1.6.7"
  sha256 "9541f89cef6aba0fcaf884489fc8b884511ba5fd320290a7ccb1e32e51051704"

  url "https://github.com/GeiserX/VPN-Bypass/releases/download/v#{version}/VPN-Bypass-#{version}.dmg"
  name "VPN Bypass"
  desc "macOS menu bar app to route specific traffic around VPN"
  homepage "https://github.com/GeiserX/VPN-Bypass"

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
