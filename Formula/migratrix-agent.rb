class MigratrixAgent < Formula
  desc "Database migration and data transformation agent"
  homepage "https://migratrix.com"
  version "3.1.8"
  
  on_macos do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/3.1.8/migratrix-agent-darwin-amd64.tar.gz"
      sha256 "bfdfeea2457698d0f0e45e4a14e4e71ad4a99b45bf82e9337aaafc8e7d679fc9"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/3.1.8/migratrix-agent-darwin-arm64.tar.gz"
      sha256 "ef19054a146968fc0e4c715a0a14042649a367dbbee0633f4c083876073e7390"
    end
  end
  
  on_linux do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/3.1.8/migratrix-agent-linux-amd64.tar.gz"
      sha256 "57d8a7f12b352ac67e118b08d2c30351ff173d2507f66cd524f63aa76db0081f"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/3.1.8/migratrix-agent-linux-arm64.tar.gz"
      sha256 "c7cca74d90b3e150ececdbfd70e7d8c1892b067f29c78381ba7931250bd5779f"
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
