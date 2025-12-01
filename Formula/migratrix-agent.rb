class MigratrixAgent < Formula
  desc "Database migration and data transformation agent"
  homepage "https://migratrix.com"
  version "3.0.07"
  
  on_macos do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/3.0.07/migratrix-agent-darwin-amd64.tar.gz"
      sha256 "61961f9ad17ee7304ad4b55a8265e51f3ace2d9a2f2e211dc0219f2654fb9cf9"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/3.0.07/migratrix-agent-darwin-arm64.tar.gz"
      sha256 "e3a5ee768377c5b10f0d7046800ccae64da742d63bcf093144b337958f58b901"
    end
  end
  
  on_linux do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/3.0.07/migratrix-agent-linux-amd64.tar.gz"
      sha256 "b97fe7e0ad0458057ebc0837f548e9f222b2f82d61749704166efaee7bcb97f6"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/3.0.07/migratrix-agent-linux-arm64.tar.gz"
      sha256 "8fc93f9a6357d3987f5a17b95b903f26035cf71f82b8634eebe722ef9566e325"
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
