class MigratrixAgent < Formula
  desc "Database migration and data transformation agent"
  homepage "https://migratrix.com"
  version "3.2.2"
  
  on_macos do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/3.2.2/migratrix-agent-darwin-amd64.tar.gz"
      sha256 "bb5452213612d3210bf33fd731a4ad9322890eb4118cb008a1711c835daa75b3"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/3.2.2/migratrix-agent-darwin-arm64.tar.gz"
      sha256 "3dc498f4476e1e9fd8394f54e1e72e7c7045ac5f223c124738eb2cc517f51a01"
    end
  end
  
  on_linux do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/3.2.2/migratrix-agent-linux-amd64.tar.gz"
      sha256 "14d5cd37cffbcab8f7994e3979fabb367cf1595434582be7439b91c51d3004d7"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/3.2.2/migratrix-agent-linux-arm64.tar.gz"
      sha256 "f4c93419056d3d865bd660f9f35c20ca0dd8c4e617cf6dbb9f8a4d09f9acf195"
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
