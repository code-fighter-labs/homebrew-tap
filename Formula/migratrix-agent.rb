class MigratrixAgent < Formula
  desc "Database migration and data transformation agent"
  homepage "https://migratrix.com"
  version "1.0.19"
  
  on_macos do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.0.17/migratrix-agent-darwin-amd64.tar.gz"
      sha256 "88fb668d2c18aa351e017f972541f68808c9d5d6d504ed41bcb1109f7ef7397c"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.0.17/migratrix-agent-darwin-arm64.tar.gz"
      sha256 "93db6b9d54b8ca204de22a4434111b58d6493bfdea5cc75d77fc2de7dff586d7"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.0.17/migratrix-agent-linux-amd64.tar.gz"
      sha256 "55b81d3e3d92a46ba9b6e342d8ce97905de2e66edc3b7124addfb96eaef7daa7"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.0.17/migratrix-agent-linux-arm64.tar.gz"
      sha256 "b252df1efa2893c9bd0eb583884804f449ead84575c86e1f86de77f30bc0a111"
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
