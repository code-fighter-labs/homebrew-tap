class MigratrixAgent < Formula
  desc "Database migration and data transformation agent"
  homepage "https://migratrix.com"
  version "1.1.2"
  
  on_macos do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.1.2/migratrix-agent-darwin-amd64.tar.gz"
      sha256 "ec6a191c66e7d539eb2f86a8525c6a9276a382f8b712f20d4da03b3881771822"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.1.2/migratrix-agent-darwin-arm64.tar.gz"
      sha256 "9336186a2a7fd17fa8e1017e362013a5560d4060d140b614693f6d7d3ec95f05"
    end
  end
  
  on_linux do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.1.2/migratrix-agent-linux-amd64.tar.gz"
      sha256 "55a628bc8b3c0c42dda49e32fa6783bdfbde41f6ce13949fa2ec57389c4ca0cc"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.1.2/migratrix-agent-linux-arm64.tar.gz"
      sha256 "d0c914951b29a55f544bff0a880f7cbdb8b5d9744bb5808bfb78fabcb8940028"
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
