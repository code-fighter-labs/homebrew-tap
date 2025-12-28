class MigratrixAgent < Formula
  desc "Database migration and data transformation agent"
  homepage "https://migratrix.com"
  version "4.4.4"
  
  on_macos do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/4.4.4/migratrix-agent-darwin-amd64.tar.gz"
      sha256 "abdcb4ffee74798fa14faee23ae2edae9b1cb607732d9ab78014fa3cc4e2d2c4"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/4.4.4/migratrix-agent-darwin-arm64.tar.gz"
      sha256 "db62c588d1465043de952d012b9f43462fda93b1b6008f71fea315932992e35b"
    end
  end
  
  on_linux do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/4.4.4/migratrix-agent-linux-amd64.tar.gz"
      sha256 "de1aec803d0af16700b1c57cc0791ad58e06cf10e6aea51efd583beffb235cba"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/4.4.4/migratrix-agent-linux-arm64.tar.gz"
      sha256 "ac3a957ed9fcdc74f924668dacfa1ba4d0794d88fb295a2ef290e5c973458095"
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
