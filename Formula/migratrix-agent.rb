class MigratrixAgent < Formula
  desc "Database migration and data transformation agent"
  homepage "https://migratrix.com"
  version "1.0.27"
  
  on_macos do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.0.27/migratrix-agent-darwin-amd64.tar.gz"
      sha256 "f2f7de2f58b1caa8ae1915c7a776debd0053488ce422434d27e6fd27fd419167"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.0.27/migratrix-agent-darwin-arm64.tar.gz"
      sha256 "0bf2dc0dd779faa3398d001176a0bb834846fa187007c896fc395bf936468413"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.0.27/migratrix-agent-linux-amd64.tar.gz"
      sha256 "f432c5d4612c5f7799111b40948cd29537f81a1f6069a748cebf01fb036ab901"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.0.27/migratrix-agent-linux-arm64.tar.gz"
      sha256 "0f0cb344122fe9e4dea5390345e4a33b8eb438186a164d1735245f87654e722e"
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
