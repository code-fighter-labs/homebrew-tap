class MigratrixAgent < Formula
  desc "Database migration and data transformation agent"
  homepage "https://migratrix.com"
  version "0.0.6"
  
  on_macos do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/0.0.6/migratrix-agent-darwin-amd64.tar.gz"
      sha256 "eaf9dd3f2004f5d5d5e5a7bd70fd922d02b140f0e0fde5ed7d3d7e89a3ec7aab"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/0.0.6/migratrix-agent-darwin-arm64.tar.gz"
      sha256 "f22dc699b6c949110a2c4aff28f0f2217de0d208dfb7f67db939b064e848ee49"
    end
  end
  
  on_linux do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/0.0.6/migratrix-agent-linux-amd64.tar.gz"
      sha256 "7b41cd34765dc55a28efdfe3ad2cb7b9ed6973c68e5bd226a6102ff9a2803c4a"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/0.0.6/migratrix-agent-linux-arm64.tar.gz"
      sha256 "7d653a966612d046caa25665b8ef85c57adc19bf6a21bdf40057a1a5903065f1"
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
