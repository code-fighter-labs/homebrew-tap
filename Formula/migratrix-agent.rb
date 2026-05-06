class MigratrixAgent < Formula
  desc "Database migration and data transformation agent"
  homepage "https://migratrix.com"
  version "1.4.1"
  
  on_macos do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.4.1/migratrix-agent-darwin-amd64.tar.gz"
      sha256 "a9d2c2576e783f393345799bd5202403b5cb575b2d6e4ca9e978f59b53c7f0cb"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.4.1/migratrix-agent-darwin-arm64.tar.gz"
      sha256 "1436d8f7651c184bdac59c8617a1b6f2de5709246f27c61fb89e12b3d7fba1e6"
    end
  end
  
  on_linux do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.4.1/migratrix-agent-linux-amd64.tar.gz"
      sha256 "1a5b5f936d33ad457437973ef5568479fe6d6959dacd9159af64cb8f81a8a7c1"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.4.1/migratrix-agent-linux-arm64.tar.gz"
      sha256 "d8103afabe72226b5645573155fd21ec8eceda7cd4e0a68600d11e12101354fe"
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
