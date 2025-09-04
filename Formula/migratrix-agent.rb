class MigratrixAgent < Formula
  desc "Database migration and data transformation agent"
  homepage "https://migratrix.com"
  version "1.2.1"
  
  on_macos do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.2.1/migratrix-agent-darwin-amd64.tar.gz"
      sha256 "6897df38d62389f04dff940eb1e97682702058639c9c75cf8a0c5fb173cba6e4"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.2.1/migratrix-agent-darwin-arm64.tar.gz"
      sha256 "c02364ca0d01e67593c4b3dc57c72ef639d99ebeb21982b1e917b903031b9a23"
    end
  end
  
  on_linux do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.2.1/migratrix-agent-linux-amd64.tar.gz"
      sha256 "dc2f8365233337462e10d675abf9ccbdde13a687ac64aedb15bdbcc6a3c52a79"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.2.1/migratrix-agent-linux-arm64.tar.gz"
      sha256 "af137fe4bd0ed36404dfb2eef5760bbc46ea54b1c7de6dbf72f9d92e8930f4b1"
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
