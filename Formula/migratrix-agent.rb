class MigratrixAgent < Formula
  desc "Database migration and data transformation agent"
  homepage "https://migratrix.com"
  version "3.0.02"
  
  on_macos do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/3.0.02/migratrix-agent-darwin-amd64.tar.gz"
      sha256 "1ff6597282340cceb8bdb0f3d71012924a3004a03a25f6b1e56f13e0add2dc88"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/3.0.02/migratrix-agent-darwin-arm64.tar.gz"
      sha256 "52f767cc75f4e9d0f54ba1104596e6a04d2058c744e88baa7fdfceff71a297d0"
    end
  end
  
  on_linux do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/3.0.02/migratrix-agent-linux-amd64.tar.gz"
      sha256 "65be0be66f1fc0bb844240e6e3d8dbd7ef52f22d069b08ced94d7d9d21f84a1d"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/3.0.02/migratrix-agent-linux-arm64.tar.gz"
      sha256 "9b9df278746fb5fdd6439d009fd8c48e0ce5375f8ebdd9116b079e2782da6f7f"
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
