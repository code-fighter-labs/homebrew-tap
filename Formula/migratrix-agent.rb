class MigratrixAgent < Formula
  desc "Database migration and data transformation agent"
  homepage "https://migratrix.com"
  version "1.4.2"
  
  on_macos do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.4.2/migratrix-agent-darwin-amd64.tar.gz"
      sha256 "0450ffa6f94d7b66273a1bc210af1f5b708ab3954e77cfea1f0f14f0798f86e9"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.4.2/migratrix-agent-darwin-arm64.tar.gz"
      sha256 "cd2aac253be649325ae204afa371549b8dbbc5a2253e451c052ca4c4edb9b1d1"
    end
  end
  
  on_linux do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.4.2/migratrix-agent-linux-amd64.tar.gz"
      sha256 "cc60bb0540cb9241a82592d97364c4352203fe54159ca028caa98c714c311021"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.4.2/migratrix-agent-linux-arm64.tar.gz"
      sha256 "efc0d4da77d1184749cc73adf27b6de774ddf2d151895aec27c8d2c82da5e64a"
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
