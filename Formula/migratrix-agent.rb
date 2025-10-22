class MigratrixAgent < Formula
  desc "Database migration and data transformation agent"
  homepage "https://migratrix.com"
  version "2.0.4"
  
  on_macos do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/2.0.4/migratrix-agent-darwin-amd64.tar.gz"
      sha256 "c570a125c46a7c67a3ebf3df27ead5b457f02dcba42ad6ee90d26aee35b518a6"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/2.0.4/migratrix-agent-darwin-arm64.tar.gz"
      sha256 "363d78facc779dd20ff158ac70ccaef396df009002d059f367b097b83430bf05"
    end
  end
  
  on_linux do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/2.0.4/migratrix-agent-linux-amd64.tar.gz"
      sha256 "dc805cfae8d1f1af1a71afc9790f09da0e94ff92ea2dbf73cde71eea305cfbb4"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/2.0.4/migratrix-agent-linux-arm64.tar.gz"
      sha256 "8f4f1d540354d60d2f093bc4f2b45fef2cf031cf4c70a79890697d27ba874c72"
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
