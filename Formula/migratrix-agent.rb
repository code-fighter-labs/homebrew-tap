class MigratrixAgent < Formula
  desc "Database migration and data transformation agent"
  homepage "https://migratrix.com"
  version "3.2.7"
  
  on_macos do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/3.2.7/migratrix-agent-darwin-amd64.tar.gz"
      sha256 "c6da12ad4f0a0a39e6c82d6b50c3e97660df9e62b85cd0fc8a88e153f01386b4"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/3.2.7/migratrix-agent-darwin-arm64.tar.gz"
      sha256 "2041e887dc4ebd1e8b92cd5c62e8af3fa8a3b2e5c272f6e7cad801983e3fc569"
    end
  end
  
  on_linux do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/3.2.7/migratrix-agent-linux-amd64.tar.gz"
      sha256 "cdb1db25a86227c9b02c65f8e717cc63bac8ebe054d03c7a79e20bc92c0d7cdf"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/3.2.7/migratrix-agent-linux-arm64.tar.gz"
      sha256 "1d9d8f80eb6cf18adbc6f6180282ef55b1f6fb738002f75187c643f2ce0b0038"
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
