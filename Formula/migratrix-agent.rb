class MigratrixAgent < Formula
  desc "Database migration and data transformation agent"
  homepage "https://migratrix.com"
  version "1.0.3"
  
  on_macos do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/0.0.02/migratrix-agent-darwin-amd64.tar.gz"
      sha256 "c2bb5bce7bff9e685694187f68590d78d0d1efc6f6bb6bfc1e4a8fd926018296"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/0.0.02/migratrix-agent-darwin-arm64.tar.gz"
      sha256 "59e16b8ae86a6f87e2a59ee91cbe7b6f1ea0697a277c22d2aaf4623575a2b015"
    end
  end
  
  on_linux do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/0.0.02/migratrix-agent-linux-amd64.tar.gz"
      sha256 "4af9109b77db388035f08739f7f14c9207b4f7f8a2725bd13e79f251bea677ba"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/0.0.02/migratrix-agent-linux-arm64.tar.gz"
      sha256 "0269a34510fbed19fd1e9502a7aad6fa1b791c922d5e3cbeef92c4d928cd5df4"
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
