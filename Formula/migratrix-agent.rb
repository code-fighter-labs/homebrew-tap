class MigratrixAgent < Formula
  desc "Database migration and data transformation agent"
  homepage "https://migratrix.com"
  version "1.3.4"
  
  on_macos do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.3.4/migratrix-agent-darwin-amd64.tar.gz"
      sha256 "6141e3041d8c75325c0453257649290bb1d6d8c5fcf01af8ce1c80b46201213b"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.3.4/migratrix-agent-darwin-arm64.tar.gz"
      sha256 "84c65a0523c4d84f61ab5b29ec471ed640b78e3644156d9e27d2a8edf6c3cdae"
    end
  end
  
  on_linux do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.3.4/migratrix-agent-linux-amd64.tar.gz"
      sha256 "20b17d65f72e83aa28b0239cc188fc461007a97679d470bdc56e2c002ef1dbbf"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.3.4/migratrix-agent-linux-arm64.tar.gz"
      sha256 "a3269bd13b92b1de53adc8c195784f1fdfaa3d5ac919662b87662096f31e2f14"
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
