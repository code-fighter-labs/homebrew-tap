class MigratrixAgent < Formula
  desc "Database migration and data transformation agent"
  homepage "https://migratrix.com"
  version "5.5.2"
  
  on_macos do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/5.5.2/migratrix-agent-darwin-amd64.tar.gz"
      sha256 "d70d9c6dcf1d378953cf78585e88ea85e1746b59be766a2a8a5767cf65d6cc19"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/5.5.2/migratrix-agent-darwin-arm64.tar.gz"
      sha256 "1620ff9ef451ccc74829cddde654f4187650fc8e46e4afd6495c362c64cb8e9a"
    end
  end
  
  on_linux do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/5.5.2/migratrix-agent-linux-amd64.tar.gz"
      sha256 "883884f4382bb0c3d4f13a28c659a6019c7ac69c881a64a5009c3e28693f2022"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/5.5.2/migratrix-agent-linux-arm64.tar.gz"
      sha256 "85a6533977c6bd66b0a08b620c0be2fd27184b34d31cd7964864e71e8190b562"
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
