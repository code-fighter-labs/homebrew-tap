class MigratrixAgent < Formula
  desc "Database migration and data transformation agent"
  homepage "https://migratrix.com"
  version "1.5.9"

  on_macos do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.5.9/migratrix-agent-darwin-amd64.tar.gz"
      sha256 "6eb71b5f9d54e45073760e3d7bab22a3cc5c560fd981d9eb836f16e7f221cdea"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.5.9/migratrix-agent-darwin-arm64.tar.gz"
      sha256 "1a345dab4bc2c2f2471fd2cdbcdecf6006735ca8b90bcf27baff917d598a23c0"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.5.9/migratrix-agent-linux-amd64.tar.gz"
      sha256 "402ac00314e57d30062f851cf0c3894d83adbad1d4a7598c776e96bcf3b69c76"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.5.9/migratrix-agent-linux-arm64.tar.gz"
      sha256 "fb174e290bf28f810e43ac03bb0102ac4ac87210ebf0c6fcf764ed063e9f4127"
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
