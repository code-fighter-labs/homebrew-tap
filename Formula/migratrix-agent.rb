class MigratrixAgent < Formula
  desc "Database migration and data transformation agent"
  homepage "https://migratrix.com"
  version "1.1.5"
  
  on_macos do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.1.5/migratrix-agent-darwin-amd64.tar.gz"
      sha256 "fe2f6d5ce5970e1b1cd708e787f9df05d080a065e697d26ccd82fed731a27557"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.1.5/migratrix-agent-darwin-arm64.tar.gz"
      sha256 "2fc88261cf86543ec225cba98c67ebd1a9aaf67204dae45e7a4eb3dac007415b"
    end
  end
  
  on_linux do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.1.5/migratrix-agent-linux-amd64.tar.gz"
      sha256 "b1594981fb7de4ae8c2424118b5e1d67750894a55024233a13fa9e50fabb3fd9"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.1.5/migratrix-agent-linux-arm64.tar.gz"
      sha256 "7c2a8505cd2d6153e6c36bd26f3e75710239edf4f7ce1e6e7a828253fae4fbf7"
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
