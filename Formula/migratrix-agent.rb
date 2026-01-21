class MigratrixAgent < Formula
  desc "Database migration and data transformation agent"
  homepage "https://migratrix.com"
  version "0.0.9"
  
  on_macos do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/0.0.9/migratrix-agent-darwin-amd64.tar.gz"
      sha256 "34563dcfe22892a2e529d282aa12822cf66d343671e1dd6508460f6cdf411e9b"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/0.0.9/migratrix-agent-darwin-arm64.tar.gz"
      sha256 "b2d61eb040413da764053a15bdf1af93adb782069936f47196ef36a499e80849"
    end
  end
  
  on_linux do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/0.0.9/migratrix-agent-linux-amd64.tar.gz"
      sha256 "8899c543af99d15c190cd29093233204c7b785ad98dcf731aaa0b282fa4528c0"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/0.0.9/migratrix-agent-linux-arm64.tar.gz"
      sha256 "9e7320100f714086f76f1b6fa17644b6878c0eed0d570209b797d1af75a4ee10"
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
