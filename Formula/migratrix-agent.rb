class MigratrixAgent < Formula
  desc "Database migration and data transformation agent"
  homepage "https://migratrix.com"
  version "3.3.7"
  
  on_macos do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/3.3.7/migratrix-agent-darwin-amd64.tar.gz"
      sha256 "9e41a6500d36df3721c5197375fef99d1b2585b1cbb8eaea079a21572917aeca"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/3.3.7/migratrix-agent-darwin-arm64.tar.gz"
      sha256 "4a5120808e2e426dac91e2dae2e296d58e38c9268d53318452284ee9e9cf0ca4"
    end
  end
  
  on_linux do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/3.3.7/migratrix-agent-linux-amd64.tar.gz"
      sha256 "e37e01c8398fbafb5e6783cfd21ddc439a19a311c948031d60a947fa6425ee11"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/3.3.7/migratrix-agent-linux-arm64.tar.gz"
      sha256 "40b59ee1803c286d148570549c6181564b5455157e8a6d1d72127582ed13ea98"
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
