class MigratrixAgent < Formula
  desc "Database migration and data transformation agent"
  homepage "https://migratrix.com"
  version "1.4.9"

  on_macos do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.4.9/migratrix-agent-darwin-amd64.tar.gz"
      sha256 "e43c868bb858d75891084326090f7ff724c435ebba9907664e0b63ff353dab47"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.4.9/migratrix-agent-darwin-arm64.tar.gz"
      sha256 "4fe8b6f9dc7248e2e5bb731ab115736f452fd27b2935c5a0061f905a0073e8be"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.4.9/migratrix-agent-linux-amd64.tar.gz"
      sha256 "8a52ce6f9cd66407f4b38e0ea15a33219ee193498138c1f9278ea834a7391822"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.4.9/migratrix-agent-linux-arm64.tar.gz"
      sha256 "70fce20f7f1b5da7d1a4b31d3966ac1667c36f0796eca0e7b3c441a9fc5d20a4"
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

  # After brew finishes the cellar swap, kick the running launchd service so
  # it respawns from the new binary. `launchctl kickstart` is a launchd RPC
  # (no file writes), which brew's post_install sandbox permits.
  #
  # Pre-condition: the user previously ran `migratrix-agent --apiKey ...`
  # AND `migratrix-agent upgrade` once, so a launchd plist exists and points
  # at /opt/homebrew/bin/migratrix-agent. We no-op if either is missing.
  def post_install
    return unless OS.mac?

    label = "com.migratrix.agent"
    service_target = "gui/#{Process.uid}/#{label}"

    # Use brew's quiet_system rather than `system(... out:, err:)` — the
    # kwargs form does NOT pass through brew's `system` wrapper and ends up
    # appended to the command as literal args, which broke the check in
    # 1.4.8.
    unless quiet_system "launchctl", "print", service_target
      ohai "migratrix-agent service not loaded; run `migratrix-agent --apiKey ...` to install it."
      return
    end

    if system "launchctl", "kickstart", "-k", service_target
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
      upgrade` once to migrate your launchd plist to the brew bin path.)
    EOS
  end

  test do
    system "#{bin}/migratrix-agent", "--version"
  end
end
