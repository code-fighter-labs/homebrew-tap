class MigratrixAgent < Formula
  desc "Database migration and data transformation agent"
  homepage "https://migratrix.com"
  version "2.1.2"
  
  on_macos do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/2.1.2/migratrix-agent-darwin-amd64.tar.gz"
      sha256 "7e36228e25b008db9b6392c2d9cb7ecb5f29baaf70007a5ff5ba09316d5a0aeb"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/2.1.2/migratrix-agent-darwin-arm64.tar.gz"
      sha256 "7f43655925c6c29894f96e2d398d037e607af85b1afd1b71fced1a6f474963db"
    end
  end
  
  on_linux do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/2.1.2/migratrix-agent-linux-amd64.tar.gz"
      sha256 "7da6cdf267245d0b06f7c60556f221cd358d5c9614c6f55ab22f9b975ae35877"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/2.1.2/migratrix-agent-linux-arm64.tar.gz"
      sha256 "1aba7f1270bfc817ef7c2ff3d46e3df500c15b5cb50d68cfecc42619ba24372e"
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
