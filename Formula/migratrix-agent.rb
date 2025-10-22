class MigratrixAgent < Formula
  desc "Database migration and data transformation agent"
  homepage "https://migratrix.com"
  version "2.0.6"
  
  on_macos do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/2.0.6/migratrix-agent-darwin-amd64.tar.gz"
      sha256 "77240e6eec6c2ead2739da88d74499edd3078aef68b266ce69cf0fd63b1d210b"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/2.0.6/migratrix-agent-darwin-arm64.tar.gz"
      sha256 "0af646aae773d618a3646a6def9d8810be9ce9d1c1b09e4846674e24c3e70eed"
    end
  end
  
  on_linux do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/2.0.6/migratrix-agent-linux-amd64.tar.gz"
      sha256 "35f6324b46639a29ef5251194ab7afc432e1bb882addd0b0172a1a239720824a"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/2.0.6/migratrix-agent-linux-arm64.tar.gz"
      sha256 "aa76c8f1505410aa221bc76df940a81ee6cc4301d939a79b6da69044cbf4cc8a"
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
