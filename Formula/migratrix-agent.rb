class MigratrixAgent < Formula
  desc "Database migration and data transformation agent"
  homepage "https://migratrix.com"
  version "2.0.19"
  
  on_macos do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/2.0.19/migratrix-agent-darwin-amd64.tar.gz"
      sha256 "60db36a6b9844207ff13f32e12801202d14239793fbcff12c96b31019c022e10"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/2.0.19/migratrix-agent-darwin-arm64.tar.gz"
      sha256 "086025d70e5b64fb388cffae84b302cf471b4fcdd498cd8d07447a96d7f3c705"
    end
  end
  
  on_linux do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/2.0.19/migratrix-agent-linux-amd64.tar.gz"
      sha256 "d89d410c983e198c6d44fc43a4d65c79f003d7bdc514c6c6160238142fec59ff"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/2.0.19/migratrix-agent-linux-arm64.tar.gz"
      sha256 "aa91c1881450dfc81a024411936fb20bc3a861efdf648140b43105877afeb5d5"
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
