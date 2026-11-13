cask "ket" do
  version "0.2.0"
  sha256 "0cc418966ca9fe1faa7e13651942b784bed56002f9b81cf3e6843c12e2a23572"

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
  depends_on macos: :ventura

  app "ket.app"
  binary "#{appdir}/ket.app/Contents/Resources/bin/ket"

  uninstall quit:   "dev.ketapp.ket",
            script: {
              executable:   "/bin/sh",
              args:         [
                "-c",
                <<~'SH',
                  [ -x "$0" ] || exit 0
                  case "$(ps -o args= -p "$PPID" | sed -n 's|.*/brew\.rb \([^ ]*\).*|\1|p')" in
                    install|upgrade|reinstall) exit 0 ;;
                  esac
                  exec "$0" uninstall-hooks
                SH
                "#{appdir}/ket.app/Contents/Resources/bin/ket",
              ],
              must_succeed: false,
            }

  zap trash: [
    "~/.cache/ket",
    "~/.config/ket",
    "~/.ket",
    "~/.local/share/ket",
  ]
end
