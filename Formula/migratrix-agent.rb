class MigratrixAgent < Formula
  desc "Database migration and data transformation agent"
  homepage "https://migratrix.com"
  version "1.3.1"
  
  on_macos do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.3.1/migratrix-agent-darwin-amd64.tar.gz"
      sha256 "adf374d211add1e0a5fa50b9eed63a29c92e1170a0b3c63260f3981d59cb0707"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.3.1/migratrix-agent-darwin-arm64.tar.gz"
      sha256 "ac1a7d75ed3f7f9e87c03c99dc0746f5ad1c973005038b14fa227967add72a82"
    end
  end
  
  on_linux do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.3.1/migratrix-agent-linux-amd64.tar.gz"
      sha256 "75fc2542c88b39961c91bcd3489ee1e4a51e0d7d487fb2aef1d708c9429c72db"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.3.1/migratrix-agent-linux-arm64.tar.gz"
      sha256 "2e3891837af5ba0c192420dadb0e23e1a337a78423e9a24241e7ddfdcd28622f"
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

  def post_install
    if File.exist?("#{libexec}/migratrix-agent") && !File.exist?("#{libexec}/migratrix-agent")
      system "mv", "#{libexec}/migratrix-agent", "#{libexec}/migratrix-agent"
    end
  end
