class MigratrixAgent < Formula
  desc "Database migration and data transformation agent"
  homepage "https://migratrix.com"
  version "3.2.0"
  
  on_macos do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/3.2.0/migratrix-agent-darwin-amd64.tar.gz"
      sha256 "d0661dd205fd3068f5e5e43f98e04f3c8c6e824ec6262ad9afa5b9126564564f"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/3.2.0/migratrix-agent-darwin-arm64.tar.gz"
      sha256 "14e3d367dbe405c22dbb3ad723c9b6848c756cbcbab5e9ddfb8e2a9c931a92f1"
    end
  end
  
  on_linux do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/3.2.0/migratrix-agent-linux-amd64.tar.gz"
      sha256 "1186cfd9eb7025f1cc1bf1bc54854cebe01027a6204ad2e07fd342ade8616821"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/3.2.0/migratrix-agent-linux-arm64.tar.gz"
      sha256 "3b4b8fc4e7999b91db8db262b43438f73c65c1e779f63be40e116b0278461439"
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
