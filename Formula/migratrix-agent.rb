class MigratrixAgent < Formula
  desc "Database migration and data transformation agent"
  homepage "https://migratrix.com"
  version "1.2.9"
  
  on_macos do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.2.9/migratrix-agent-darwin-amd64.tar.gz"
      sha256 "c732f856d60d17b652b2f25c2cf1564fa47d4d6647873377f1a5178edaeccdbc"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.2.9/migratrix-agent-darwin-arm64.tar.gz"
      sha256 "2775e1cd83bdde16fc10fe9c26459be9f975f5c6e7cfdff435a2c1b5ab4e7def"
    end
  end
  
  on_linux do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.2.9/migratrix-agent-linux-amd64.tar.gz"
      sha256 "da36d59d0bab39609d38359b06c2eb521a9e76077528e519432a62ec9db95207"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.2.9/migratrix-agent-linux-arm64.tar.gz"
      sha256 "f434997b5659dc736e08f3da304ba41a71c6b63439f10e69bd97fdb48e764035"
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
