class MigratrixAgent < Formula
  desc "Database migration and data transformation agent"
  homepage "https://migratrix.com"
  version "5.5.4"
  
  on_macos do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/5.5.4/migratrix-agent-darwin-amd64.tar.gz"
      sha256 "7c1ffdad79804efeb7fbf5dc45a577f1eea3bd374775e0c1320d1525c51d7fa3"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/5.5.4/migratrix-agent-darwin-arm64.tar.gz"
      sha256 "f25bbe1458a02fa721a5f79cbf50078c43e085dfa5ddc175a3117a5937cfae73"
    end
  end
  
  on_linux do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/5.5.4/migratrix-agent-linux-amd64.tar.gz"
      sha256 "03fa3bc7508abcb521f6d067ab2876e2814a488e322d9c7003019f589d5dd870"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/5.5.4/migratrix-agent-linux-arm64.tar.gz"
      sha256 "3f817f40355b678c3ca95f6333ecbf0070e828630f248be93325aa6789e9685f"
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
