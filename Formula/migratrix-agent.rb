class MigratrixAgent < Formula
  desc "Database migration and data transformation agent"
  homepage "https://migratrix.com"
  version "4.4.1"
  
  on_macos do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/4.4.1/migratrix-agent-darwin-amd64.tar.gz"
      sha256 "994112241485fb299dd9cd05093758d41a7c473d7a9a6f5a626f4809cd1dcad4"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/4.4.1/migratrix-agent-darwin-arm64.tar.gz"
      sha256 "c49f2090865c8d302557e153967d5d1271be3b63994ce9254e9c137f16e1ff3d"
    end
  end
  
  on_linux do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/4.4.1/migratrix-agent-linux-amd64.tar.gz"
      sha256 "eab0be3ccab20e79f9203130a79a98f3871ed702188c351af7a62df990290adb"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/4.4.1/migratrix-agent-linux-arm64.tar.gz"
      sha256 "ee93a99076c2f1a9e7d26dd62d0a767b8d942739c95f1e23b80190b694f27b4a"
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
