class MigratrixAgent < Formula
  desc "Database migration and data transformation agent"
  homepage "https://migratrix.com"
  version "1.5.2"

  on_macos do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.5.2/migratrix-agent-darwin-amd64.tar.gz"
      sha256 "ed0b3f898622ffd29b105aabc11491bd9a74d2ac1a8c36c1cdbbe3ed34b37c99"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.5.2/migratrix-agent-darwin-arm64.tar.gz"
      sha256 "00c6a6432c24166dc9deda62f76ef394320f4695c520d6e6dd2d701c57916a04"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.5.2/migratrix-agent-linux-amd64.tar.gz"
      sha256 "482600c540a7918db1438ffe8f5adc3d5ad3a01616b6698c69776cb64255be74"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.5.2/migratrix-agent-linux-arm64.tar.gz"
      sha256 "bbed9d040030fdb9994c041e672bcb6ad08fd6e66d20adb5ada7fd3b3330baab"
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
