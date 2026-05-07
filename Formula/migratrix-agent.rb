class MigratrixAgent < Formula
  desc "Database migration and data transformation agent"
  homepage "https://migratrix.com"
  version "1.5.1"

  on_macos do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.5.1/migratrix-agent-darwin-amd64.tar.gz"
      sha256 "a0fd6acf15576f90a69c4458ec5ee8768aa83d105a78013cb4fb49cae971af0b"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.5.1/migratrix-agent-darwin-arm64.tar.gz"
      sha256 "b2cefdcfcc5ba305c758c0f6cd32c80e86378a34decc397e2206a7a62fcca328"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.5.1/migratrix-agent-linux-amd64.tar.gz"
      sha256 "3d3843157c2f3d2263c71aed68ce11e2a52205867206825f414407df53b66b2c"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.5.1/migratrix-agent-linux-arm64.tar.gz"
      sha256 "2a4189c5dbf05ffd9a9b23aaad2595532484a59540449ccb6de01be4caf53329"
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
      ohai "#{label} is not loaded — run `migratrix-agent --apiKey YOUR_KEY` to set it up."
      return
    end

    # We intentionally *stop* rather than kickstart here. Homebrew calls
    # post_install before relinking bin/ to the new keg, so kickstart -k
    # would relaunch the old binary. Stopping lets launchd respawn the
    # service after Homebrew finishes the relink, at which point
    # $(brew --prefix)/bin/migratrix-agent already resolves to the new binary.
    if quiet_system "launchctl", "stop", service_target
      ohai "Stopped #{label} — launchd will respawn it from the new binary."
    else
      opoo "Could not stop #{label}. Restart manually with:"
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
