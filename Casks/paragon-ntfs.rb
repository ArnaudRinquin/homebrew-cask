cask "paragon-ntfs" do
  version "15"
  sha256 :no_check # required as upstream package is updated in-place

  url "https://dl.paragon-software.com/demo/ntfsmac#{version}_trial.dmg"
  name "Paragon NTFS for Mac"
  desc "Paragon read-write NTFS driver"
  homepage "https://www.paragon-software.com/ufsdhome/ntfs-mac/"

  livecheck do
    url :homepage
    regex(%r{href=.*?/ntfsmac(\d+)_trial\.dmg}i)
  end

  auto_updates true

  installer manual: "FSInstaller.app"

  uninstall kext:      "com.paragon-software.filesystems.ntfs",
            launchctl: "com.paragon-software.ntfs*",
            pkgutil:   "com.paragon-software.pkg.ntfs",
            quit:      "com.paragon-software.ntfs*",
            signal:    [
              ["KILL", "com.paragon-software.ntfs.FSMenuApp"],
              ["KILL", "com.paragon-software.ntfs.notification-agent"],
            ]

  zap trash: [
    "~/Library/Application Support/com.paragon-software.ntfs.*",
    "~/Library/Caches/com.paragon-software.ntfs.fsapp",
    "~/Library/HTTPStorages/com.paragon-software.ntfs.*",
    "~/Library/Preferences/com.paragon-software.ntfs.fsapp.plist",
    "~/Library/Saved Application State/com.paragon-software.ntfs.fsapp.savedState",
    "~/Library/WebKit/com.paragon-software.ntfs.fsapp",
  ]
end
