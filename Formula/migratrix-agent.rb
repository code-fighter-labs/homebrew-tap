class MigratrixAgent < Formula
  desc "Database migration and data transformation agent"
  homepage "https://migratrix.com"
  version "1.4.0"
  
  on_macos do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.4.0/migratrix-agent-darwin-amd64.tar.gz"
      sha256 "bfc947a6ff31676e60ba593c192b76d2b7afb9aaf05fefa4573558dd04615bfd"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.4.0/migratrix-agent-darwin-arm64.tar.gz"
      sha256 "f26a8ecf066300f28594bed25df59f53c328caba8f0361296cab8cd5fe865eb7"
    end
  end
  
  on_linux do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.4.0/migratrix-agent-linux-amd64.tar.gz"
      sha256 "7ef1b5978b422ea6c67391341995bb49267c6fb69c78691f7684fba121ef2e32"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.4.0/migratrix-agent-linux-arm64.tar.gz"
      sha256 "0aed54e78b81127e9349a2d96602d5e0b483b0f5e8f6eb6d1a3122b108563459"
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
