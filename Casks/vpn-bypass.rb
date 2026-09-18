cask "vpn-bypass" do
  version "4.8.4"
  sha256 "d026d2976a93224a6176ca30baaa1f5f466686d9e3d558174ab632445923a160"

  url "https://github.com/GeiserX/VPN-Bypass/releases/download/v#{version}/VPN-Bypass-#{version}.dmg"
  name "VPN Bypass"
  desc "Menu bar app to route specific traffic around VPN"
  homepage "https://github.com/GeiserX/VPN-Bypass"

  depends_on macos: :ventura

  app "VPN Bypass.app"
  binary "#{appdir}/VPN Bypass.app/Contents/MacOS/vpnb"

  preflight_steps do
    terminate_process "VPNBypass"
  end

  postflight_steps do
    # must_succeed is spelled out because `run` defaults to true while the old
    # system_command defaulted to false; without it a failed re-sign would start
    # aborting installs that used to finish.
    run "/usr/bin/xattr",
        args:         ["-cr", "{{appdir}}/VPN Bypass.app"],
        must_succeed: false

    run "/usr/bin/codesign",
        args:         ["--force", "--deep", "--sign", "-", "{{appdir}}/VPN Bypass.app"],
        must_succeed: false

    run "/usr/bin/open",
        args:         ["{{appdir}}/VPN Bypass.app"],
        must_succeed: false
  end

  zap trash: [
    "~/Library/Application Support/VPNBypass",
    "~/Library/Caches/com.geiserx.vpn-bypass",
    "~/Library/Preferences/com.geiserx.vpn-bypass.plist",
  ]
end
