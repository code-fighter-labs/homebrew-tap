class MigratrixAgent < Formula
  desc "Database migration and data transformation agent"
  homepage "https://migratrix.com"
  version "0.0.4"
  
  on_macos do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/0.0.4/migratrix-agent-darwin-amd64.tar.gz"
      sha256 "ab52e0fb5f02ca849903a3cf916f91b90c0aaf6f242e40f50129cce7fd594c76"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/0.0.4/migratrix-agent-darwin-arm64.tar.gz"
      sha256 "6276b5a874dac219054a72329f6f41077b6c577ab2f20e260bb23b5404384a34"
    end
  end
  
  on_linux do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/0.0.4/migratrix-agent-linux-amd64.tar.gz"
      sha256 "ee4b08a97a7c4bf51437d73b2c4a6b545791aa3033e43a6b4e195854258ad018"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/0.0.4/migratrix-agent-linux-arm64.tar.gz"
      sha256 "7c7a875f258542e67dbd9c99fa7e522aefe3cf6ef1bd0588198ff454f7e55e4b"
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
