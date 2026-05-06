class MigratrixAgent < Formula
  desc "Database migration and data transformation agent"
  homepage "https://migratrix.com"
  version "1.4.6"

  on_macos do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.4.6/migratrix-agent-darwin-amd64.tar.gz"
      sha256 "04dc695b911af02458052e54573b9a2f50d43aa9ba36dfca051ec7276b436da9"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.4.6/migratrix-agent-darwin-arm64.tar.gz"
      sha256 "f9197353d593e772b74fb3fe397acdc070ee2415371a17c4f22b5ffb62833546"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.4.6/migratrix-agent-linux-amd64.tar.gz"
      sha256 "04e7238380140b8d9cac4520259a2f4c9a359df649fa3e708d81c32c23e4fbe8"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.4.6/migratrix-agent-linux-arm64.tar.gz"
      sha256 "06dd7befa01f863fe374e8a16d6a5444d2ef086a3c2f64892df2ebc446f3427a"
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
