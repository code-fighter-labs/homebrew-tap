class MigratrixAgent < Formula
  desc "Database migration and data transformation agent"
  homepage "https://migratrix.com"
  version "4.4.6"
  
  on_macos do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/4.4.6/migratrix-agent-darwin-amd64.tar.gz"
      sha256 "8a2475f1ccb9233a4526538278ca2e8c57219674bc70c194f3bd7552d909add2"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/4.4.6/migratrix-agent-darwin-arm64.tar.gz"
      sha256 "5b715879d256b7d0334184c0bd43793962b8cfb2fcf835b7fbcc5ba59d59b6da"
    end
  end
  
  on_linux do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/4.4.6/migratrix-agent-linux-amd64.tar.gz"
      sha256 "7bcb91ac5fa6a064bb84aa392108523b5169fffcb8b81f5a81a1878b6e5b947d"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/4.4.6/migratrix-agent-linux-arm64.tar.gz"
      sha256 "071abf5471defadbfbdc13ac90515a0b0d95413eb49331cae203c0cdbc4f2ff6"
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
