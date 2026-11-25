cask "ionized-bar-nightly" do
  version "2026-11-25"
  sha256 "359f821a797454e1c53858b03dee83f464263986e4c4e0f3fc37954a2d6ef23f" # set by ionized-bar's nightly workflow

  url "https://github.com/adericbourg/ionized-bar/releases/download/nightly-#{version}/IonizedBar-nightly-#{version}.zip"
  name "Ionized Bar Nightly"
  desc "Daily build of IonizedBar from main"
  homepage "https://github.com/adericbourg/ionized-bar"

  livecheck do
    skip "Updated daily by ionized-bar's nightly workflow"
  end

  conflicts_with cask: "ionized-bar"
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
    This is an unreleased daily build of IonizedBar's main branch.

    IonizedBar needs macOS 27.2 or later.

    The app is self-signed, not notarized, so this cask removes its
    Gatekeeper quarantine attribute after installing it.

    IonizedBar hides the Dock (autohide in com.apple.dock) while it runs.
    Quitting it or uninstalling the cask restores the Dock.
  EOS
end
