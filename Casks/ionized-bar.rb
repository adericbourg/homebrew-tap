cask "ionized-bar" do
  version "0.7.0"
  sha256 "b0c8ad399662474f33c860c4070c9985530ef4d78221be82861bec27360bdf78" # sha256 printed by scripts/archive.sh / shown on the v0.1.0 release

  url "https://github.com/adericbourg/ionized-bar/releases/download/v#{version}/IonizedBar-#{version}.zip"
  name "Ionized Bar"
  desc "KDE Plasma-style taskbar that replaces the Dock"
  homepage "https://github.com/adericbourg/ionized-bar"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on arch: :arm64
  depends_on macos: :golden_gate

  app "IonizedBar.app"

  # Self-signed, not notarized: Gatekeeper would block the quarantined app
  postflight_steps do
    run "/usr/bin/xattr",
        args:           ["-dr", "com.apple.quarantine", "{{appdir}}/IonizedBar.app"],
        writable_paths: ["IonizedBar.app"],
        writable_base:  :appdir
  end

  uninstall quit:       "io.github.adericbourg.ionized-bar",
            login_item: "IonizedBar"

  zap trash: [
    "~/Library/Preferences/io.github.adericbourg.ionized-bar.plist",
    "~/Library/Saved Application State/io.github.adericbourg.ionized-bar.savedState",
  ]

  caveats <<~EOS
    IonizedBar needs macOS 27.2 or later.

    The app is self-signed, not notarized, so this cask removes its
    Gatekeeper quarantine attribute after installing it.

    IonizedBar hides the Dock (autohide in com.apple.dock) while it runs.
    Quitting it or uninstalling the cask restores the Dock.
  EOS
end
