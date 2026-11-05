cask "ket" do
  version "0.1.0"
  sha256 "0000000000000000000000000000000000000000000000000000000000000000"

  url "https://github.com/ketapp/ket/releases/download/v#{version}/ket-#{version}.dmg",
      verified: "github.com/ketapp/ket/"
  name "ket"
  desc "Run coding agents side by side in worktrees"
  homepage "https://ketapp.dev/"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on arch: :arm64
  depends_on macos: ">= :big_sur"

  app "ket.app"
  binary "#{appdir}/ket.app/Contents/Resources/bin/ket"

  zap trash: [
    "~/.cache/ket",
    "~/.config/ket",
    "~/.ket",
    "~/.local/share/ket",
  ]
end
