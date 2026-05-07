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

def post_install
  return unless OS.mac?

  label = "com.migratrix.agent"
  service_target = "gui/#{Process.uid}/#{label}"

  unless quiet_system "launchctl", "print", service_target
    ohai "migratrix-agent service not loaded; run `migratrix-agent --apiKey ...` to install it."
    return
  end

  require "open3"
  out, status = Open3.capture2e("launchctl", "kickstart", "-k", service_target)

  if status.success?
    ohai "Restarted #{label} — service is now running the new binary."
    return
  end

  opoo "launchctl kickstart failed (exit #{status.exitstatus}): #{out.strip}"

  if quiet_system "pkill", "-TERM", "-u", Process.uid.to_s, "-f", "/Cellar/migratrix-agent/"
    ohai "Sent SIGTERM to old migratrix-agent — launchd is respawning from the new binary."
    return
  end

  opoo "Could not auto-restart #{label}. Run manually:"
  opoo "  launchctl kickstart -k #{service_target}"
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
