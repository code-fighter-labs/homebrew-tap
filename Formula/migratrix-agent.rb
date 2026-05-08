class MigratrixAgent < Formula
  desc "Database migration and data transformation agent"
  homepage "https://migratrix.com"
  version "1.5.6"

  on_macos do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.5.6/migratrix-agent-darwin-amd64.tar.gz"
      sha256 "af240cc01b93424234677845d94ed9b723c5089f1a65320a38f749c0d6abcd23"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.5.6/migratrix-agent-darwin-arm64.tar.gz"
      sha256 "aa510b0f4963e73cd12cf98e2969dd7b3ad5f72dac2185d857504a6b1c795c01"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.5.6/migratrix-agent-linux-amd64.tar.gz"
      sha256 "c1e7f08dc0b3effe0fa64cd11c6c85c2df870d888371c1b5eb8f752d7961341f"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.5.6/migratrix-agent-linux-arm64.tar.gz"
      sha256 "ae62a9b17c55cd7b83ee57a1db8712a3b6a1afe77be4b3325fea99a20fdffb4f"
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
