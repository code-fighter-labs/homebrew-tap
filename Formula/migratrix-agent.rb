class MigratrixAgent < Formula
  desc "Database migration and data transformation agent"
  homepage "https://migratrix.com"
  version "1.5.4"
  revision 1

  on_macos do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.5.4/migratrix-agent-darwin-amd64.tar.gz"
      sha256 "a31a7833728f44b2b52460bbacf44a0ee2463e64a8dd70bd5234d30deffee763"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.5.4/migratrix-agent-darwin-arm64.tar.gz"
      sha256 "f95c459eaf679604d8a082b7c50f6750f2fab317bad323b425913507561b0360"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.5.4/migratrix-agent-linux-amd64.tar.gz"
      sha256 "d10fc25ffd1cd1f60651c97a1aa30c1b61fe741eb9235b7c0bdd963871361aa4"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.5.4/migratrix-agent-linux-arm64.tar.gz"
      sha256 "eb2ed83e779f8e51278dc1268df68829b4704efcd2314d6e1a5cc037e4bc2891"
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
