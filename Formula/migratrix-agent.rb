class MigratrixAgent < Formula
  desc "Database migration and data transformation agent"
  homepage "https://migratrix.com"
  version "1.3.9"
  
  on_macos do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.3.9/migratrix-agent-darwin-amd64.tar.gz"
      sha256 "627856fd2d2769d38b6f72a55c2ddca4444f34f9e3909de6f9f10df628c01e88"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.3.9/migratrix-agent-darwin-arm64.tar.gz"
      sha256 "86704a4cffe2e139f36033a9b3e3d381deba128fed0d0cd369454bbbdbc78a16"
    end
  end
  
  on_linux do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.3.9/migratrix-agent-linux-amd64.tar.gz"
      sha256 "cd14f8ca7026f237ba008f8cc404683db2f1635df07bf4ceba19dd6d1001c943"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.3.9/migratrix-agent-linux-arm64.tar.gz"
      sha256 "93af47ad98768e6c522f6b470abed67972cd482f2f8c173b2e74a0339ab338c2"
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
