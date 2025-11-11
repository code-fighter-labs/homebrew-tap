class MigratrixAgent < Formula
  desc "Database migration and data transformation agent"
  homepage "https://migratrix.com"
  version "2.0.15"
  
  on_macos do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/2.0.15/migratrix-agent-darwin-amd64.tar.gz"
      sha256 "9da9814aeb93997c6c8a7ab93382144b1d7b6d921b0255ad9997ff928a25220e"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/2.0.15/migratrix-agent-darwin-arm64.tar.gz"
      sha256 "252e6ca6a48ddbb5281ca10ec8b6c685d952b9bdbd1834e1ba5cb2d39f4d42a2"
    end
  end
  
  on_linux do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/2.0.15/migratrix-agent-linux-amd64.tar.gz"
      sha256 "cfc8398b2fc11220df6ecaf3f9053f9f1b3654c8a9326676681fdb009debccd7"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/2.0.15/migratrix-agent-linux-arm64.tar.gz"
      sha256 "4da192daa09a33aedc684481e4b330862b51c069e3c47fd26d5a3e6be4c89e12"
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
