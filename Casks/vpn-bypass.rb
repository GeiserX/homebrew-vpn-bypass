# Homebrew Cask for VPN Bypass
# Install: brew install --cask geiserx/tap/vpn-bypass
# Or if using local tap: brew install --cask --no-quarantine ./Casks/vpn-bypass.rb

cask "vpn-bypass" do
  version "2.1.0"
  sha256 "0c45bdd3e82e3b69432283aa29e20cea101d2c1616e1e73e9289906db19d472a"

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
    # Remove quarantine attribute to avoid Gatekeeper warning
    system_command "/usr/bin/xattr",
                   args: ["-cr", "#{appdir}/VPN Bypass.app"],
                   sudo: false

    # Sign the app after installation (ad-hoc) for notifications to work
    system_command "/usr/bin/codesign",
                   args: ["--force", "--deep", "--sign", "-", "#{appdir}/VPN Bypass.app"],
                   sudo: false

    # Relaunch the app after upgrade
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
