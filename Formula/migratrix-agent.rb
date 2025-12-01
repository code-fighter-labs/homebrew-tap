class MigratrixAgent < Formula
  desc "Database migration and data transformation agent"
  homepage "https://migratrix.com"
  version "3.0.09"
  
  on_macos do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/3.0.09/migratrix-agent-darwin-amd64.tar.gz"
      sha256 "9f9597b6896248e71d6e847495bce223b3c2383ca57c3a527bc9556704a1f762"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/3.0.09/migratrix-agent-darwin-arm64.tar.gz"
      sha256 "86953d06c63f9976c28fc0e4e076654a54d512ff156c148b5e66a74fa09fda73"
    end
  end
  
  on_linux do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/3.0.09/migratrix-agent-linux-amd64.tar.gz"
      sha256 "c20bf2cbfd2265212b23fb05dbe5cab9a52e039055abb1f1ff8ade29aa330233"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/3.0.09/migratrix-agent-linux-arm64.tar.gz"
      sha256 "4b2bdcbcb73579f97942a5837fe2e18fb7038591255e10ef1b7a0e6a6be3f72a"
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
