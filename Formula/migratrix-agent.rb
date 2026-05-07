class MigratrixAgent < Formula
  desc "Database migration and data transformation agent"
  homepage "https://migratrix.com"
  version "1.5.0"

  on_macos do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.5.0/migratrix-agent-darwin-amd64.tar.gz"
      sha256 "0553a93d3aee01aac8f5595d4166c6238d641836b740708b6c48cb56dacc57d2"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.5.0/migratrix-agent-darwin-arm64.tar.gz"
      sha256 "de2318f8a92e67202fece5ddb9f49b5c953299fbf50be60aace2f23b61829807"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.5.0/migratrix-agent-linux-amd64.tar.gz"
      sha256 "4ecc664a48aa48abce4137ed023d5955077f221384728bae3e6f7d6167acbc8c"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.5.0/migratrix-agent-linux-arm64.tar.gz"
      sha256 "99fc567e565cc905ec39868eaf279b1963991108abf9c85965f3fa077fe6a2b9"
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
