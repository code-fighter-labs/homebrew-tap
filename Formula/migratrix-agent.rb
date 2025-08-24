class MigratrixAgent < Formula
  desc "Database migration and data transformation agent"
  homepage "https://migratrix.com"
  version "1.1.2"
  
  on_macos do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.1.2/migratrix-agent-darwin-amd64.tar.gz"
      sha256 "da45f27c4fad830c3adbb8566e3dc719e2a2461b7107c0c8dcc959389fe453c5"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.1.2/migratrix-agent-darwin-arm64.tar.gz"
      sha256 "ad853cc93eed346832448aa1229ea70222c17e474295e21fd8df7bff0513da76"
    end
  end
  
  on_linux do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.1.2/migratrix-agent-linux-amd64.tar.gz"
      sha256 "c19f8d0f7ac92f49a7348542e2c19f7edf10b9a9c5107d23ac67586c8d37629f"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.1.2/migratrix-agent-linux-arm64.tar.gz"
      sha256 "62b0d59c166ed649d291866ee2e22026dc3c1e55f84705895eadf36e6b24c57c"
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
