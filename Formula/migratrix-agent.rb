class MigratrixAgent < Formula
  desc "Database migration and data transformation agent"
  homepage "https://migratrix.com"
  version "2.0.1"
  
  on_macos do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/2.0.1/migratrix-agent-darwin-amd64.tar.gz"
      sha256 "186973a93459d80b5c007e5f1b9bcd2cff06ac20331b3eae6ba7d6458e4407c7"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/2.0.1/migratrix-agent-darwin-arm64.tar.gz"
      sha256 "69a04368155b004b960785478c59f280b9aa433a5e66bae5ae4bd52da43d9f07"
    end
  end
  
  on_linux do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/2.0.1/migratrix-agent-linux-amd64.tar.gz"
      sha256 "308d5eb83399bea80ea3887c24538bff268d7bd839152c5b6f631d04fd9cc128"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/2.0.1/migratrix-agent-linux-arm64.tar.gz"
      sha256 "9268e68f4a08d26130e0862abcf9ea4517931a9652995d1f93e2ea005986e0ea"
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
