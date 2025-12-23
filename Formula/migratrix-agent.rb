class MigratrixAgent < Formula
  desc "Database migration and data transformation agent"
  homepage "https://migratrix.com"
  version "3.2.1"
  
  on_macos do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/3.2.1/migratrix-agent-darwin-amd64.tar.gz"
      sha256 "570540147e07f7c54d25bc7f548a9b0c42d09afa456defd4612142e7d8e18efe"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/3.2.1/migratrix-agent-darwin-arm64.tar.gz"
      sha256 "6d67c8d04593f9f7f09faf8dc49642affed6a4a1b6dbf97c7b0db4bf0a81958d"
    end
  end
  
  on_linux do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/3.2.1/migratrix-agent-linux-amd64.tar.gz"
      sha256 "7fbd8762d1ae2ff97f70f8cf0450fb6a83ccaa203c7b03557ad133be9914be01"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/3.2.1/migratrix-agent-linux-arm64.tar.gz"
      sha256 "ad8f39827d2eadda463bc136bb7967c35cc1ffb2e91b7d717600e174f353068a"
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
