# The version and the sum are rewritten by `.github/workflows/bump.yml`, which
# reads the newest release of kbarendrecht/orchestrator and the `.sha256` asset
# published beside the dmg. Edit them by hand only to roll a bad bump back.
cask "orchestrator" do
  version "2026.9.27"
  sha256 "03a403e4824a8d77bc1707cab0092a4cd9eaf197fc68d2f90dfa26a27de4d400"

  url "https://github.com/kbarendrecht/orchestrator/releases/download/v#{version}/Orchestrator_#{version}_aarch64.dmg"
  name "Orchestrator"
  desc "Hosts several Claude Code sessions over one monorepo"
  homepage "https://github.com/kbarendrecht/orchestrator"

  livecheck do
    url :url
    strategy :github_latest
  end

  # Apple Silicon only, and that is the build rather than a policy: every Mac
  # sold since 2020 is arm64, so the release runs one macOS leg. An Intel Mac
  # gets a clear refusal here instead of an app that will not launch.
  depends_on arch: :arm64

  app "Orchestrator.app"
  # `orch` ships inside the bundle, beside the app and the daemon, and
  # `Contents/MacOS` is on nobody's PATH. An agent session does not need this —
  # the daemon prepends its own directory to every session's PATH — but your
  # shell does.
  binary "#{appdir}/Orchestrator.app/Contents/MacOS/orch"

  # Everything durable the daemon writes: the config, the session store, the
  # hook settings, the per-checkout state. `Config::config_dir` puts it here on
  # macOS.
  zap trash: [
    "~/Library/Application Support/orchd",
  ]
end
