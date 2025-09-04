class MigratrixAgent < Formula
  desc "Database migration and data transformation agent"
  homepage "https://migratrix.com"
  version "1.1.15"
  
  on_macos do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.1.15/migratrix-agent-darwin-amd64.tar.gz"
      sha256 "759099c70967f9c7d6ef74e3ae35799f94e6db7e0a8dead5ccd0f9163e4e3370"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.1.15/migratrix-agent-darwin-arm64.tar.gz"
      sha256 "23cb5165f0f65bb76966b08e139a52a6834558bb04327afee037b27055869374"
    end
  end
  
  on_linux do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.1.15/migratrix-agent-linux-amd64.tar.gz"
      sha256 "6aaeb32e900c938f51cf1d5641214518858bfb43f39971a50d9bc390e897e2d5"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.1.15/migratrix-agent-linux-arm64.tar.gz"
      sha256 "d1125f1cad15ff3464ef71d302b616aaaa61de07687a4a58648c3836b84d4b5d"
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
