class MigratrixAgent < Formula
  desc "Database migration and data transformation agent"
  homepage "https://migratrix.com"
  version "1.1.7"
  
  on_macos do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.1.7/migratrix-agent-darwin-amd64.tar.gz"
      sha256 "291ffee7347a3c4aea9d6bfb7b6d09ba99d450e04f39154060447ea047777161"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.1.7/migratrix-agent-darwin-arm64.tar.gz"
      sha256 "cbcbbcefd43ba9a7b7e02c84aaa09793c01d52c2a77d6a6299a2a9caba6f4421"
    end
  end
  
  on_linux do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.1.7/migratrix-agent-linux-amd64.tar.gz"
      sha256 "ed9587430b33ec465d06b6e1f8df9931206fd70424f069688cf55763620512f2"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.1.7/migratrix-agent-linux-arm64.tar.gz"
      sha256 "0a756996f98dc47343f848f17ce074991e81ad985bc9e6d6c7e24c9f48e42221"
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
