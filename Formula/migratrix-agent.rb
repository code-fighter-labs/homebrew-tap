class MigratrixAgent < Formula
  desc "Database migration and data transformation agent"
  homepage "https://migratrix.com"
  version "1.2.8"
  
  on_macos do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.2.8/migratrix-agent-darwin-amd64.tar.gz"
      sha256 "3b63f4efbb66f40f07865ac8a896624363de22b9675a4d31b4ab4b8cc0a34730"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.2.8/migratrix-agent-darwin-arm64.tar.gz"
      sha256 "3602ee22d41a8b4bc7bb4fd85c3d3c1d3842c3fe7f87c6063469365bd8c02213"
    end
  end
  
  on_linux do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.2.8/migratrix-agent-linux-amd64.tar.gz"
      sha256 "d9475d4b97cf8143b9935079bdf7965ebd3ff1a0c57782685ae6de79fc02009c"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.2.8/migratrix-agent-linux-arm64.tar.gz"
      sha256 "0a82b50c562c64809ce5ee15410df9dde580fae47bed633bdb603ee7510a66a2"
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
