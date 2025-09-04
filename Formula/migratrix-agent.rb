class MigratrixAgent < Formula
  desc "Database migration and data transformation agent"
  homepage "https://migratrix.com"
  version "1.1.19"
  
  on_macos do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.1.19/migratrix-agent-darwin-amd64.tar.gz"
      sha256 "2ce17c9208dc4cfd00ce5ab543468e6aa08f1f171506b38f2b474b9e0764f042"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.1.19/migratrix-agent-darwin-arm64.tar.gz"
      sha256 "92b9caa4bd7f34e81c9993a78c9eb098c8652d84eba1d4879781143572ab5d77"
    end
  end
  
  on_linux do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.1.19/migratrix-agent-linux-amd64.tar.gz"
      sha256 "83c89c4b111887a6d153017c19949b29a1b840000c7898683534761664cbdf23"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.1.19/migratrix-agent-linux-arm64.tar.gz"
      sha256 "df70c72f0da15e2fb88213a464183520c573120c1775dfd0d3d6b26742378104"
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
        exec "#{libexec}/Migratrix.Api.Agent" "$@"
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
