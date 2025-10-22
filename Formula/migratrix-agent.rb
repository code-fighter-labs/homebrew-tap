class MigratrixAgent < Formula
  desc "Database migration and data transformation agent"
  homepage "https://migratrix.com"
  version "2.0.2"
  
  on_macos do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/2.0.2/migratrix-agent-darwin-amd64.tar.gz"
      sha256 "f44ac76c346ca4c3feff4bdd4d0ceb2f61c054fd2334ee8ae47fccf0b8de47df"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/2.0.2/migratrix-agent-darwin-arm64.tar.gz"
      sha256 "e73c0fb01aa5578d0bdd651dbcf85a37ad0e9c1e067696634bedb31b9b82b5de"
    end
  end
  
  on_linux do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/2.0.2/migratrix-agent-linux-amd64.tar.gz"
      sha256 "cfc8f3300fd780921604fb03c318be098df690016fb8e88b076386779d62212b"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/2.0.2/migratrix-agent-linux-arm64.tar.gz"
      sha256 "1cf68e1706662355383a0b557dafc47ebe8ceff62cef80a4ff30bdd448f8a433"
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
