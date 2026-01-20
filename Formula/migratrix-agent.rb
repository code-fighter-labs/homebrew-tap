class MigratrixAgent < Formula
  desc "Database migration and data transformation agent"
  homepage "https://migratrix.com"
  version "0.0.2"
  
  on_macos do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/0.0.2/migratrix-agent-darwin-amd64.tar.gz"
      sha256 "8bd34708f87940cb9f21035b38eb836d18084ad1e9181e62831f50754c6a89c1"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/0.0.2/migratrix-agent-darwin-arm64.tar.gz"
      sha256 "ba4627aa40e5cb6a4ff21c4908d239ea40e2fbb5ca4f37f6ea1d238718dc258b"
    end
  end
  
  on_linux do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/0.0.2/migratrix-agent-linux-amd64.tar.gz"
      sha256 "955ed0e7e572cb07248637255e36e84cc6e402e9991b2f088dcfbc9ffcfcc707"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/0.0.2/migratrix-agent-linux-arm64.tar.gz"
      sha256 "700e7de35e8b55aea13d9ac3be0db473704eddc3f827991911d4d8c5d5ea2bfe"
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
    if File.exist?("#{libexec}/Migratrix.Api.Agent") && !File.exist?("#{libexec}/migratrix-agent")
      system "mv", "#{libexec}/Migratrix.Api.Agent", "#{libexec}/migratrix-agent"
    end
  end
