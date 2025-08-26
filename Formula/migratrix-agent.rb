class MigratrixAgent < Formula
  desc "Database migration and data transformation agent"
  homepage "https://migratrix.com"
  version "1.1.9"
  
  on_macos do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.1.9/migratrix-agent-darwin-amd64.tar.gz"
      sha256 "1cf4669f8a2755b6bbcb75ca1b8a74a506b3e93ea43f59d34949f36e58811fbf"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.1.9/migratrix-agent-darwin-arm64.tar.gz"
      sha256 "d84af83c2529f45d8f8aad638c54ac9147ab468ffe5f4a61c703c4199610ec35"
    end
  end
  
  on_linux do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.1.9/migratrix-agent-linux-amd64.tar.gz"
      sha256 "ac92b378bf5344aea6c70d9650e8a6f70c21fad6dd3fb9bef51d47ad672c241e"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.1.9/migratrix-agent-linux-arm64.tar.gz"
      sha256 "220a0eacb2a0e0e9e21a2c9ac768225bc8ccf8d6ff29b16f7f21ac3bdc87dd75"
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
