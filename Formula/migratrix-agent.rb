class MigratrixAgent < Formula
  desc "Database migration and data transformation agent"
  homepage "https://migratrix.com"
  version "3.2.4"
  
  on_macos do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/3.2.4/migratrix-agent-darwin-amd64.tar.gz"
      sha256 "6fc2dd942bf3377da730ef049aea9e52fbc6e46b4ba730a73ace2c08cd7dc423"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/3.2.4/migratrix-agent-darwin-arm64.tar.gz"
      sha256 "85f323b0e097d765698c0bf0b8eb1e86d67acf34727ddf03907ce4976a5c79b0"
    end
  end
  
  on_linux do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/3.2.4/migratrix-agent-linux-amd64.tar.gz"
      sha256 "e7eec3ee769ac98dd9f4e0d8093cfe3487644bb490e03b94ad57d5e36507da11"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/3.2.4/migratrix-agent-linux-arm64.tar.gz"
      sha256 "dadf4d3cb08a11e9b856491abeee9bbaa2b74347d03749831ad26225515d7b14"
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
