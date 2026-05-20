class MigratrixAgent < Formula
  desc "Database migration and data transformation agent"
  homepage "https://migratrix.com"
  version "1.6.0"

  on_macos do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.6.0/migratrix-agent-darwin-amd64.tar.gz"
      sha256 "84246d7f2109be19dae175ecb179c934a8ec53cd0a3e718f90ac47c3711d6603"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.6.0/migratrix-agent-darwin-arm64.tar.gz"
      sha256 "2795090110ae01232f5739d407875c9823d0123f980bc0a4d7df3d6a0a45afaf"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.6.0/migratrix-agent-linux-amd64.tar.gz"
      sha256 "b8c33a7ce795d916a3f5745638f81e0057ccc90766dc81f3adeacf585bb344ee"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.6.0/migratrix-agent-linux-arm64.tar.gz"
      sha256 "c4a6121e0580f24dc1b4af9eb3d14021a7520d13a64e57541ffd3d3b3c325031"
    end
  end

  def install
    if OS.mac?
      libexec.install Dir["*"]
      (bin/"migratrix-agent").write <<~EOS
        #!/bin/bash
        export DOTNET_BUNDLE_EXTRACT_BASE_DIR="${HOME}/Library/Caches/Migratrix/Agent/dotnet-bundle/#{version}"
        mkdir -p "${DOTNET_BUNDLE_EXTRACT_BASE_DIR}"
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
    service_target = [
      "gui/#{Process.uid}/#{label}",
      "user/#{Process.uid}/#{label}",
    ].find { |target| quiet_system "launchctl", "print", target }

    unless service_target
      ohai "#{label} is not loaded — run `migratrix-agent --apiKey YOUR_KEY` to set it up."
      return
    end

    if quiet_system "launchctl", "kickstart", "-k", service_target
      ohai "Restarted #{label} — service is now running the new binary."
    else
      opoo "Could not restart #{label}. Run manually:"
      opoo "  launchctl kickstart -k #{service_target}"
    end
  end

  def caveats
    <<~EOS
      First-time setup:
        migratrix-agent --apiKey YOUR_API_KEY

      Subsequent upgrades are handled automatically:
        brew upgrade migratrix-agent

      (One-time only, if upgrading from pre-1.4.5: run `migratrix-agent upgrade`
      once to migrate your launchd plist to the stable brew bin path.)
    EOS
  end

  test do
    system bin/"migratrix-agent", "--version"
  end
end
