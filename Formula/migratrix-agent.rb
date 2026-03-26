class MigratrixAgent < Formula
  desc "Database migration and data transformation agent"
  homepage "https://migratrix.com"
  version "1.3.5"
  
  on_macos do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.3.5/migratrix-agent-darwin-amd64.tar.gz"
      sha256 "787a19f6ebebcac8ea5e549b52c0d18cb0715957321f4e86ef300776c0eb6f94"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.3.5/migratrix-agent-darwin-arm64.tar.gz"
      sha256 "849c45f0170e02b2107003aaa80414eb5abaa7b6b7f2c8d2b05f2397b0ca173c"
    end
  end
  
  on_linux do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.3.5/migratrix-agent-linux-amd64.tar.gz"
      sha256 "e12eff60dbdf7879d4d59e1b3008c25136e68c88693e8406fa1252bb3be7bd21"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.3.5/migratrix-agent-linux-arm64.tar.gz"
      sha256 "574d75e1ad7fcbbc7bd447db3c4e9c4da9612ab595bb473c6d0cb7bb4aed858c"
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
