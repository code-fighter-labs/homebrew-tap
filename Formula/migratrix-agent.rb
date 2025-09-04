class MigratrixAgent < Formula
  desc "Database migration and data transformation agent"
  homepage "https://migratrix.com"
  version "1.2.2"
  
  on_macos do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.2.2/migratrix-agent-darwin-amd64.tar.gz"
      sha256 "fcd26035bf895fd6e4807815a2ea1a83bcb6986198cf96ef1275051a5cb71bdf"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.2.2/migratrix-agent-darwin-arm64.tar.gz"
      sha256 "6112b4783f498f1169beb06ce220738893d9599008567b7cade9a0cef741dbcd"
    end
  end
  
  on_linux do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.2.2/migratrix-agent-linux-amd64.tar.gz"
      sha256 "67267dfc4fddf5cab0d4775e3759e7ff1223de95f692c67b3c0c2efa78606884"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.2.2/migratrix-agent-linux-arm64.tar.gz"
      sha256 "0094cd7e567ee41ff3b9a933f7a41b2fa007c22146bceed82a946b088bdbfbbb"
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
