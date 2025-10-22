class MigratrixAgent < Formula
  desc "Database migration and data transformation agent"
  homepage "https://migratrix.com"
  version "1.0.4"
  
  on_macos do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/0.0.02/migratrix-agent-darwin-amd64.tar.gz"
      sha256 "7dd2e5b367ed4e90ad447706a0f7fd002f9edf940ef03c65038665f15804d54d"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/0.0.02/migratrix-agent-darwin-arm64.tar.gz"
      sha256 "5abb993ecab833336443a124f22fbef981384e70b46a1e108da063b27896e3b0"
    end
  end
  
  on_linux do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/0.0.02/migratrix-agent-linux-amd64.tar.gz"
      sha256 "f161093b662b53563042c31d95457301cc501e026cd13719c96b3193477534d1"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/0.0.02/migratrix-agent-linux-arm64.tar.gz"
      sha256 "b1486f811cdcecb295ff2f78935c4f0595b88912bc973b5fb827b202c704f334"
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
