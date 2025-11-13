class MigratrixAgent < Formula
  desc "Database migration and data transformation agent"
  homepage "https://migratrix.com"
  version "2.1.3"
  
  on_macos do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/2.1.3/migratrix-agent-darwin-amd64.tar.gz"
      sha256 "43d497bbc120b3d7edc83719f77efb7efb5d525ff27bceeae103d19f74d99610"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/2.1.3/migratrix-agent-darwin-arm64.tar.gz"
      sha256 "f310feceeb715c87554852d86ac399b9d2ffaf714003a08c35c04272f4cb7663"
    end
  end
  
  on_linux do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/2.1.3/migratrix-agent-linux-amd64.tar.gz"
      sha256 "22f9740b91e5865e30c681a53b961227bbae7087438a7c19dae8b9c06a615d42"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/2.1.3/migratrix-agent-linux-arm64.tar.gz"
      sha256 "4b2fd8a3496ad3604477a2e60277a2b800fee0ca1d4bf0ea35866f3a75212c1b"
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
