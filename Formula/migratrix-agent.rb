class MigratrixAgent < Formula
  desc "Database migration and data transformation agent"
  homepage "https://migratrix.com"
  version "5.5.3"
  
  on_macos do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/5.5.3/migratrix-agent-darwin-amd64.tar.gz"
      sha256 "b03f8a390b9977c82a8681fe9a11d2d1d1ab4f1531cfbbbf5390287aaded40c9"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/5.5.3/migratrix-agent-darwin-arm64.tar.gz"
      sha256 "3ab2634a6e64b136bc30098f7fb5d4a2dcb083e5c6f748706617c88c50785c06"
    end
  end
  
  on_linux do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/5.5.3/migratrix-agent-linux-amd64.tar.gz"
      sha256 "d5d1419fe81cb3b9e4ef5de3829afaa5af351537f8a87e6a4da591028772c596"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/5.5.3/migratrix-agent-linux-arm64.tar.gz"
      sha256 "7563b032614e7cd7532c1da9881536029479f8d0daa7ceb53df4f4c8e65e5eb7"
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
