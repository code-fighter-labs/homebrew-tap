class MigratrixAgent < Formula
  desc "Database migration and data transformation agent"
  homepage "https://migratrix.com"
  version "3.1.9"
  
  on_macos do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/3.1.9/migratrix-agent-darwin-amd64.tar.gz"
      sha256 "33568a75a77885e7d9d011588b7c37c2e3b27114dca7a204788580dfc8e06873"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/3.1.9/migratrix-agent-darwin-arm64.tar.gz"
      sha256 "aae0750024b1d43fedd7f04e726c3153dc286e956cfb7ac01695d201c7f1c80e"
    end
  end
  
  on_linux do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/3.1.9/migratrix-agent-linux-amd64.tar.gz"
      sha256 "7ea4a4fbf9b9f2796c453d7994707c041be50af1f4bdcd6c8024f3cfabca80e8"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/3.1.9/migratrix-agent-linux-arm64.tar.gz"
      sha256 "33529c9b8e00c52f6a39a8d8228f7e21db2133c00b5e9421d2cd7e97e99b15ee"
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
