class MigratrixAgent < Formula
  desc "Database migration and data transformation agent"
  homepage "https://migratrix.com"
  version "3.1.10"
  
  on_macos do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/3.1.10/migratrix-agent-darwin-amd64.tar.gz"
      sha256 "11e31c80e5ac2b06dc2cabe27464415df1ed6687d0e2d416f47993a888674007"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/3.1.10/migratrix-agent-darwin-arm64.tar.gz"
      sha256 "642e32bd54880f04f11d9c90be7fe1ccd4106999f53ffb0293ccc79769013932"
    end
  end
  
  on_linux do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/3.1.10/migratrix-agent-linux-amd64.tar.gz"
      sha256 "d64293754f109e7ffa3dac32ecf1522e0ccb26fedbc1b0e7277744b3e821b7d9"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/3.1.10/migratrix-agent-linux-arm64.tar.gz"
      sha256 "08a207d11e8908a9d497a44f1b7b4c3e24f43f58833385b67300b46cb21b7fa6"
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
