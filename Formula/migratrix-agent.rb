class MigratrixAgent < Formula
  desc "Database migration and data transformation agent"
  homepage "https://migratrix.com"
  version "3.0.01"
  
  on_macos do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/3.0.01/migratrix-agent-darwin-amd64.tar.gz"
      sha256 "b736c05b01f84ea1a80657d43bd090d09af6f8dde7165fbdb65a7c5d19f936d0"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/3.0.01/migratrix-agent-darwin-arm64.tar.gz"
      sha256 "31e41a83406f4a840ce290b8f2d98eea70d2875fc265b5091de851dee046b392"
    end
  end
  
  on_linux do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/3.0.01/migratrix-agent-linux-amd64.tar.gz"
      sha256 "4f4f70635b9fda6901bf58984930093f9317554c845a7a9b625b9eb22801231b"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/3.0.01/migratrix-agent-linux-arm64.tar.gz"
      sha256 "bdc666ea90c532359bf5599c34aa333b3f09d450d4afa4218d333ab26f249a26"
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
