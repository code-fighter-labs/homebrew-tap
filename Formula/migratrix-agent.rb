class MigratrixAgent < Formula
  desc "Database migration and data transformation agent"
  homepage "https://migratrix.com"
  version "4.4.9"
  
  on_macos do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/4.4.9/migratrix-agent-darwin-amd64.tar.gz"
      sha256 "5002bd4a167bce2e6ed06fdad726ac3869c9f5a479b6949f697f9e82e450327b"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/4.4.9/migratrix-agent-darwin-arm64.tar.gz"
      sha256 "0e5f054d230d265f088d7fe4e08026a383f30b68b0ed178b6c9a07f79355e175"
    end
  end
  
  on_linux do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/4.4.9/migratrix-agent-linux-amd64.tar.gz"
      sha256 "cbe597e70819042045a8284408f16cc2e2baa18f30b513eed1983bd162e077e9"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/4.4.9/migratrix-agent-linux-arm64.tar.gz"
      sha256 "4af9d27da0e8590f63e718d3288cc75e6fbae028ea367c6b6627d6a44265054a"
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
