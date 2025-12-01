class MigratrixAgent < Formula
  desc "Database migration and data transformation agent"
  homepage "https://migratrix.com"
  version "3.0.11"
  
  on_macos do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/3.0.11/migratrix-agent-darwin-amd64.tar.gz"
      sha256 "8646781904e59a0d350684e8d24a763665aa894857d3a9bfadd946cd78e03827"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/3.0.11/migratrix-agent-darwin-arm64.tar.gz"
      sha256 "0c0b11fa37adf8a938500f81cb26128f7d70cc58bb3004495d7613639271352e"
    end
  end
  
  on_linux do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/3.0.11/migratrix-agent-linux-amd64.tar.gz"
      sha256 "7ee31e767d4f6b343d569a941fe964f4eaa3bbe91bf1258fcfdda25022ffcebe"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/3.0.11/migratrix-agent-linux-arm64.tar.gz"
      sha256 "54def203bf89d63b02147439e6f665ca11de70b1c86050263e7c62c5e7a32cdb"
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
