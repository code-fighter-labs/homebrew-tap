class MigratrixAgent < Formula
  desc "Database migration and data transformation agent"
  homepage "https://migratrix.com"
  version "3.2.6"
  
  on_macos do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/3.2.6/migratrix-agent-darwin-amd64.tar.gz"
      sha256 "8da7de24ee3cf9845f3d3204d1701ccb81c9002a1575a40f2cc33179700003e1"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/3.2.6/migratrix-agent-darwin-arm64.tar.gz"
      sha256 "1772dc5258494d4a17958521fe0dbdcc935baa1996dde964c462d38b00c1405f"
    end
  end
  
  on_linux do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/3.2.6/migratrix-agent-linux-amd64.tar.gz"
      sha256 "e2de731fa9bf532d5256e9e8fc9ae2157943247fbfa7fd4f5d49178736a6c8da"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/3.2.6/migratrix-agent-linux-arm64.tar.gz"
      sha256 "bf01a5194671da46171b7110f653716873c796d55a847dfe44c64c4603748f59"
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
