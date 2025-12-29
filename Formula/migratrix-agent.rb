class MigratrixAgent < Formula
  desc "Database migration and data transformation agent"
  homepage "https://migratrix.com"
  version "4.4.5"
  
  on_macos do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/4.4.5/migratrix-agent-darwin-amd64.tar.gz"
      sha256 "a87ec4c497b97f49e2e4cb476f8a3b30d652f4bd9719ad0c465af800275940fe"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/4.4.5/migratrix-agent-darwin-arm64.tar.gz"
      sha256 "9f1bedf53319da9b2e91e754428d9722567b5987afb57d53edeca87b972b1c0b"
    end
  end
  
  on_linux do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/4.4.5/migratrix-agent-linux-amd64.tar.gz"
      sha256 "e2050b1ebfaae41b034ebdaa54a7bc253e450e37079d974317fa5033df29d432"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/4.4.5/migratrix-agent-linux-arm64.tar.gz"
      sha256 "5f13f291c5c1c60cbf63a6efe069457cf7e42df6dff23f50fa8fc33bab4f6e93"
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
