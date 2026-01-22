class MigratrixAgent < Formula
  desc "Database migration and data transformation agent"
  homepage "https://migratrix.com"
  version "1.1.1"
  
  on_macos do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.1.1/migratrix-agent-darwin-amd64.tar.gz"
      sha256 "bda214b29d2601cd61319e06cc7f3b3ca17c17f71539f5eccfb0f145d2aad8d9"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.1.1/migratrix-agent-darwin-arm64.tar.gz"
      sha256 "03ff240fcbed90fd03ade1d6b0d6bc38e723071d588d6a4b484c4d7867f953a8"
    end
  end
  
  on_linux do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.1.1/migratrix-agent-linux-amd64.tar.gz"
      sha256 "7daad2f6c526123948bf9cf4c87066ab17d881d4717ce487e09758d869d5acca"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.1.1/migratrix-agent-linux-arm64.tar.gz"
      sha256 "d0adbf7a755585cfb7435b5268a2344a0ec12b7af33e9619c4ced435a0da2cfb"
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
