class MigratrixAgent < Formula
  desc "Database migration and data transformation agent"
  homepage "https://migratrix.com"
  version "1.5.5"

  on_macos do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.5.5/migratrix-agent-darwin-amd64.tar.gz"
      sha256 "fc63b7531d608b9884d674bce692a30e5f9b952fa23070331acdb5ec3a4453b1"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.5.5/migratrix-agent-darwin-arm64.tar.gz"
      sha256 "72d132daa5762edb8df55ec696c6c260d6765bf3da259213ee57b98cb47b5720"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.5.5/migratrix-agent-linux-amd64.tar.gz"
      sha256 "c2609780179a8abf46bec4d20985945dff514e13c301c001d1718e3c036d25a8"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.5.5/migratrix-agent-linux-arm64.tar.gz"
      sha256 "342790a22ce8eca42f52410600510e845eb4b4716c028e7b8be34e9b2f32f59c"
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
