cask "mac-compose" do
  version "0.1.1"
  sha256 "9654f234d25eb5bf8b85a124ec75c40172d8f94fe044f03b3245a61842f5d9fd" # set by the release workflow

  url "https://github.com/adericbourg/mac-compose/releases/download/v#{version}/MacCompose-#{version}.zip"
  name "MacCompose"
  desc "Compose key, like WinCompose"
  homepage "https://github.com/adericbourg/mac-compose"

  livecheck do
    url :url
    strategy :github_latest
  end

  conflicts_with cask: "mac-compose-nightly"
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
    MacCompose needs macOS 27.2 or later.

    The app is self-signed, not notarized, so this cask removes its
    Gatekeeper quarantine attribute after installing it.
  EOS
end
