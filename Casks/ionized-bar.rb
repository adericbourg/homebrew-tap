cask "ionized-bar" do
  version "0.1.0"
  sha256 "TODO" # sha256 printed by scripts/archive.sh / shown on the v0.1.0 release

  url "https://github.com/adericbourg/ionized-bar/releases/download/v#{version}/IonizedBar-#{version}.zip",
      verified: "github.com/adericbourg/ionized-bar/"
  name "Ionized Bar"
  desc "KDE Plasma-style taskbar that replaces the Dock"
  homepage "https://github.com/adericbourg/ionized-bar"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on arch: :arm64
  depends_on macos: ">= 27.2"

  app "IonizedBar.app"

  uninstall quit:       "io.github.adericbourg.ionized-bar",
            login_item: "IonizedBar"

  zap trash: [
    "~/Library/Preferences/io.github.adericbourg.ionized-bar.plist",
    "~/Library/Saved Application State/io.github.adericbourg.ionized-bar.savedState",
  ]

  caveats <<~EOS
    The app is not signed or notarized yet. If macOS refuses to open it:
      xattr -d com.apple.quarantine /Applications/IonizedBar.app

    IonizedBar hides the Dock (autohide in com.apple.dock) while it runs.
    Quitting it or uninstalling the cask restores the Dock.

    After each upgrade, grant the Accessibility permission again in
    System Settings > Privacy & Security > Accessibility.
  EOS
end
