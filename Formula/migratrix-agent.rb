class MigratrixAgent < Formula
  desc "Database migration and data transformation agent"
  homepage "https://migratrix.com"
  version "3.3.1"
  
  on_macos do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/3.3.1/migratrix-agent-darwin-amd64.tar.gz"
      sha256 "d295c9183a469f2752977a27efc250ad9f748809e9c0f90fb14779bc9cb16fff"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/3.3.1/migratrix-agent-darwin-arm64.tar.gz"
      sha256 "a03e54f0e441a5f0f47808b983ba576ef830a60a5cdf373f932d102fdd3b9d7e"
    end
  end
  
  on_linux do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/3.3.1/migratrix-agent-linux-amd64.tar.gz"
      sha256 "a1bfdb405f50205aa72cfa333f2b09933ea07a2b9e3a03d2e934c878a6a48329"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/3.3.1/migratrix-agent-linux-arm64.tar.gz"
      sha256 "be0dc0e4fa83f90f5da30aab2d1578c839ecf7054d4a1c7ea216bd672c4810c2"
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
