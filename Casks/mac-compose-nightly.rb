cask "mac-compose-nightly" do
  version "2026-11-17"
  sha256 "87718c3ee6ae66e8c0acf31521447ce6c16a118b1d41ed845d1e8bafc9e1526d" # set by mac-compose's nightly workflow

  url "https://github.com/adericbourg/mac-compose/releases/download/nightly-#{version}/MacCompose-nightly-#{version}.zip"
  name "MacCompose Nightly"
  desc "Daily build of MacCompose, a Compose key"
  homepage "https://github.com/adericbourg/mac-compose"

  livecheck do
    skip "Updated daily by mac-compose's nightly workflow"
  end

  conflicts_with cask: "mac-compose"
  depends_on arch: :arm64
  depends_on macos: :golden_gate

  app "MacCompose.app"

  # Self-signed, not notarized: Gatekeeper would block the quarantined app
  postflight_steps do
    run "/usr/bin/xattr",
        args:           ["-dr", "com.apple.quarantine", "{{appdir}}/MacCompose.app"],
        writable_paths: ["MacCompose.app"],
        writable_base:  :appdir
  end

  uninstall quit: "io.github.adericbourg.mac-compose"

  zap trash: "~/Library/Preferences/io.github.adericbourg.mac-compose.plist"

  caveats <<~EOS
    This is an unreleased daily build of MacCompose's main branch.

    MacCompose needs macOS 27.2 or later.

    The app is self-signed, not notarized, so this cask removes its
    Gatekeeper quarantine attribute after installing it.
  EOS
end
