class MigratrixAgent < Formula
  desc "Database migration and data transformation agent"
  homepage "https://migratrix.com"
  version "1.0.20"
  
  on_macos do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.0.17/migratrix-agent-darwin-amd64.tar.gz"
      sha256 "64148ea4433619d9935a0c36f2e1d51a4a1a16a9a5f033d621ecaa740112934a"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.0.17/migratrix-agent-darwin-arm64.tar.gz"
      sha256 "3e9803de9484cffe5bc8e7d141755ceaded889d2de3a0abae9c907a6e03334d5"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.0.17/migratrix-agent-linux-amd64.tar.gz"
      sha256 "01238e5c9281e55543be507b709fb76d77e602cc9b76acc4f12ad32176bd2773"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.0.17/migratrix-agent-linux-arm64.tar.gz"
      sha256 "ec578788160e48f892e2027a9423c872065ab82c394ac163f247243aa21c015d"
    end
  end

  def install
    if OS.mac?
      # For macOS multi-file deployment
      # Install all files to libexec to keep them together
      libexec.install Dir["*"]
      
      # Create a wrapper script in bin that calls the actual executable
      (bin/"migratrix-agent").write <<~EOS
        #!/bin/bash
        exec "#{libexec}/Migratrix.Api.Agent" "$@"
      EOS
      
      # Make the wrapper executable
      chmod 0755, bin/"migratrix-agent"
    else
      # For Linux single-file deployment
      bin.install "migratrix-agent"
    end
  end

  test do
    system "#{bin}/migratrix-agent", "--version"
  end
end
