class MigratrixAgent < Formula
  desc "Database migration and data transformation agent"
  homepage "https://migratrix.com"
  version "3.2.8"
  
  on_macos do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/3.2.8/migratrix-agent-darwin-amd64.tar.gz"
      sha256 "4f968ef78e41581afe435970b0664b261fac1f779a0606fcb9270b2e74614eec"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/3.2.8/migratrix-agent-darwin-arm64.tar.gz"
      sha256 "3634ec4818048d097ed71e61df5da4c36b491aaf1df15e4ea78929e900ff15f1"
    end
  end
  
  on_linux do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/3.2.8/migratrix-agent-linux-amd64.tar.gz"
      sha256 "acc684cb60fdd8368e24d0a0ea6e310de2f6033d5c01f07a0bc4b8710bc09dee"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/3.2.8/migratrix-agent-linux-arm64.tar.gz"
      sha256 "d13383d5a0d5e02f4ee3cd387edab6e9aff76ba233bad05be880071be2bc4a80"
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
