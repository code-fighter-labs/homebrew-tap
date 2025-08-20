class MigratrixAgent < Formula
  desc "Database migration and data transformation agent"
  homepage "https://migratrix.com"
  version "1.0.29"
  
  on_macos do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.0.29/migratrix-agent-darwin-amd64.tar.gz"
      sha256 "4285ce5484489c781c62dc8b4ef8e59ad9fc5de048965e7602a35b2b1424821a"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.0.29/migratrix-agent-darwin-arm64.tar.gz"
      sha256 "0fead6e2204c724a9c48418a426ba86a8e074fd81a507c0fc04c8f54edc034ab"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.0.29/migratrix-agent-linux-amd64.tar.gz"
      sha256 "d0d178298c06b5f937eb320ce4934ec21d8a95407b9b1aaf2891562f830172ad"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.0.29/migratrix-agent-linux-arm64.tar.gz"
      sha256 "964e3bcc4f148f494ebf9af7e65e381e5939cba579fae273a13c575ca2b4bdf8"
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
