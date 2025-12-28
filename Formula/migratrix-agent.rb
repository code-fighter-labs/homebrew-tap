class MigratrixAgent < Formula
  desc "Database migration and data transformation agent"
  homepage "https://migratrix.com"
  version "4.4.2"
  
  on_macos do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/4.4.2/migratrix-agent-darwin-amd64.tar.gz"
      sha256 "6e2ccd8322d212c52a4cb2a72d87121044ba398584844a1da724e027f5ecfc51"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/4.4.2/migratrix-agent-darwin-arm64.tar.gz"
      sha256 "da9cf6731fea5280679432b6816ac9ce7a3085d20ef25022d54538f520142a67"
    end
  end
  
  on_linux do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/4.4.2/migratrix-agent-linux-amd64.tar.gz"
      sha256 "0b21ff42fa9fc577175fed9bd6f5da2626e67a3ccb52995817882b77ac95ad1f"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/4.4.2/migratrix-agent-linux-arm64.tar.gz"
      sha256 "d3ca6361a79669fb4a68a052b0a4cdb673bc914ca48236eb1ab5083be1d611a3"
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
