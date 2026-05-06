class MigratrixAgent < Formula
  desc "Database migration and data transformation agent"
  homepage "https://migratrix.com"
  version "1.4.7"

  on_macos do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.4.7/migratrix-agent-darwin-amd64.tar.gz"
      sha256 "b0e1748fc8a43a72a3791e261f9c669fc1b8624e9e830465f22c90ac3ceaa7ac"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.4.7/migratrix-agent-darwin-arm64.tar.gz"
      sha256 "40040668e655261a2d8b7115f0a47b03d8dfd7b48fd445e6e548eb2fa346f3bd"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.4.7/migratrix-agent-linux-amd64.tar.gz"
      sha256 "031ed8e249a1d5e5822ed5218f8f001fbe0824e183c982e947b6425b314af1de"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.4.7/migratrix-agent-linux-arm64.tar.gz"
      sha256 "10cd461631ed20e4d58fd7f0738c8a692334e7f307ad71127f4685d6f92d6473"
    end
  end

  def install
    if OS.mac?
      libexec.install Dir["*"]

      (bin/"migratrix-agent").write <<~EOS
        #!/bin/bash
        exec "#{libexec}/migratrix-agent" "$@"
      EOS
      chmod 0755, bin/"migratrix-agent"
    else
      bin.install "migratrix-agent"
    end
  end

  # Intentionally a no-op. Brew's post_install runs inside a sandbox that
  # forbids writes to ~/Library/LaunchAgents and ~/Applications, so anything
  # this method does that touches user-home paths will fail with EPERM.
  # The actual service refresh has to happen outside the sandbox — see
  # `caveats` below for the user-facing instructions.
  def post_install
    ohai "Run `migratrix-agent upgrade` to refresh the installed service binary."
  end

  def caveats
    <<~EOS
      First-time setup:
        migratrix-agent --apiKey YOUR_API_KEY

      After every `brew upgrade migratrix-agent`, restart the service so it
      picks up the new binary. The one-time command after upgrading from
      pre-1.4.5 is:
        migratrix-agent upgrade
      That migrates your launchd plist to point at the brew bin symlink,
      so future upgrades only need:
        launchctl kickstart -k gui/$(id -u)/com.migratrix.agent
      (or `migratrix-agent upgrade` again — both work).
    EOS
  end

  test do
    system "#{bin}/migratrix-agent", "--version"
  end
end
