class MigratrixAgent < Formula
  desc "Database migration and data transformation agent"
  homepage "https://migratrix.com"
  version "1.1.18"
  
  on_macos do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.1.18/migratrix-agent-darwin-amd64.tar.gz"
      sha256 "7989735a07aced7bd9d94b9af1825eb3feb44c5253b261688558c3d598961cfa"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.1.18/migratrix-agent-darwin-arm64.tar.gz"
      sha256 "45aaa7297574b50c76adfffad68cd30eb6a411119f651077a4c9eaf9248957f7"
    end
  end
  
  on_linux do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.1.18/migratrix-agent-linux-amd64.tar.gz"
      sha256 "0c8a35b1d4bb10a44eba8ba813b4204443a3f5775a191206c28bd93cab10766c"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.1.18/migratrix-agent-linux-arm64.tar.gz"
      sha256 "7706d5dcb2ba12f7800136405c276c1d541e4a7626a9f622ac0657ce32d7a685"
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
