class MigratrixAgent < Formula
  desc "Database migration and data transformation agent"
  homepage "https://migratrix.com"
  version "1.2.6"
  
  on_macos do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.2.6/migratrix-agent-darwin-amd64.tar.gz"
      sha256 "1951df108ca258b7b9c86bd325589c95d4e96b977b2a4d9e2560d0eeea8b87e4"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.2.6/migratrix-agent-darwin-arm64.tar.gz"
      sha256 "7da19320d2a6e37f830834fbf3bf37bdc0416cdc50026d397529aa2d444ead87"
    end
  end
  
  on_linux do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.2.6/migratrix-agent-linux-amd64.tar.gz"
      sha256 "c6d18abe2daced1ef22e993e9121432942ecc006b733c946da2ba18d38c06d34"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.2.6/migratrix-agent-linux-arm64.tar.gz"
      sha256 "aefa018a2538d84adb5f94c7bccf86275da869303a6b6af62f174cf7ab0dc480"
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
