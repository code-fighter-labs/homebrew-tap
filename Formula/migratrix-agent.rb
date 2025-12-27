class MigratrixAgent < Formula
  desc "Database migration and data transformation agent"
  homepage "https://migratrix.com"
  version "3.3.4"
  
  on_macos do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/3.3.4/migratrix-agent-darwin-amd64.tar.gz"
      sha256 "694d8fb1a9ae037c0218c7d2099f33aa458c244f78485d9deaecb476bc2e5367"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/3.3.4/migratrix-agent-darwin-arm64.tar.gz"
      sha256 "c57e5dfde1f10aca0c2ba61372f35213fb9d38889f0beb3464a1b4fd9acf719c"
    end
  end
  
  on_linux do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/3.3.4/migratrix-agent-linux-amd64.tar.gz"
      sha256 "9032fc4a9a794d063210222cd9b7bde34472631ffa0fba650962e1d96a39a5dd"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/3.3.4/migratrix-agent-linux-arm64.tar.gz"
      sha256 "f94ea49f76b281d76bd3803687567604e512c358a5e395df500fc82dca2fe0f1"
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
