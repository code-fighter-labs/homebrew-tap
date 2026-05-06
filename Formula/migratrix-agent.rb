class MigratrixAgent < Formula
  desc "Database migration and data transformation agent"
  homepage "https://migratrix.com"
  version "1.4.8"

  on_macos do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.4.8/migratrix-agent-darwin-amd64.tar.gz"
      sha256 "REPLACE_WITH_DARWIN_AMD64_SHA256"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.4.8/migratrix-agent-darwin-arm64.tar.gz"
      sha256 "REPLACE_WITH_DARWIN_ARM64_SHA256"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.4.8/migratrix-agent-linux-amd64.tar.gz"
      sha256 "REPLACE_WITH_LINUX_AMD64_SHA256"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.4.8/migratrix-agent-linux-arm64.tar.gz"
      sha256 "REPLACE_WITH_LINUX_ARM64_SHA256"
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

  # After brew finishes the cellar swap, kick the running launchd service
  # so it respawns from the new binary. This is a pure launchd RPC, not a
  # file write, so it works from inside brew's post_install sandbox (unlike
  # `migratrix-agent upgrade`, which has to rewrite the plist).
  #
  # Pre-condition: the user has previously run `migratrix-agent --apiKey ...`
  # AND `migratrix-agent upgrade` once, so the launchd plist exists and
  # points at /opt/homebrew/bin/migratrix-agent. Both conditions are
  # checked here — we no-op if the service isn't installed.
  def post_install
    return unless OS.mac?

    label = "com.migratrix.agent"
    service_target = "gui/#{Process.uid}/#{label}"

    # Skip if the service isn't loaded. `launchctl print` exits non-zero
    # when the target isn't registered, which is the case for brew users
    # who haven't completed first-time setup.
    loaded = system("launchctl", "print", service_target,
                    out: File::NULL, err: File::NULL)
    unless loaded
      ohai "migratrix-agent service not loaded; run `migratrix-agent --apiKey ...` to install it."
      return
    end

    # `kickstart -k` stops the current instance (if running) and starts a
    # new one. With KeepAlive=true on the plist, the start would happen
    # anyway after a stop, but -k makes the sequence explicit and quick.
    if system("launchctl", "kickstart", "-k", service_target)
      ohai "Restarted #{label} — service is now running the new binary."
    else
      opoo "Could not kickstart #{label}. Run `launchctl kickstart -k #{service_target}` manually."
    end
  end

  def caveats
    <<~EOS
      First-time setup:
        migratrix-agent --apiKey YOUR_API_KEY

      Subsequent upgrades:
        brew upgrade migratrix-agent
      The service auto-restarts as part of the upgrade.

      (One-time only, if upgrading from pre-1.4.5: run `migratrix-agent
      upgrade` once to migrate your launchd plist to the brew bin path.
      After that, `brew upgrade migratrix-agent` is the entire upgrade UX.)
    EOS
  end

  test do
    system "#{bin}/migratrix-agent", "--version"
  end
end
