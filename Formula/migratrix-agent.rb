class MigratrixAgent < Formula
  desc "Database migration and data transformation agent"
  homepage "https://migratrix.com"
  version "3.3.8"
  
  on_macos do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/3.3.8/migratrix-agent-darwin-amd64.tar.gz"
      sha256 "10bb2ebde46f3994e955f9b4dccd94045757ec844bb97d5ca92d4cd5de4e9cac"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/3.3.8/migratrix-agent-darwin-arm64.tar.gz"
      sha256 "15bbee2f94779e18816b8eb934d62a21d23cb1f3299539853d87991b6da3bc5b"
    end
  end
  
  on_linux do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/3.3.8/migratrix-agent-linux-amd64.tar.gz"
      sha256 "2d1fc3a1034e03cc907a7d6efbe985ea06e4b3d1ec66c3eb4cdc552c13250726"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/3.3.8/migratrix-agent-linux-arm64.tar.gz"
      sha256 "089ee061503bf280f421a98b820340c5d8470ba6041d49b56dc29e6a524cf5b8"
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
        exec "#{libexec}/migratrix-agent" "$@"
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
