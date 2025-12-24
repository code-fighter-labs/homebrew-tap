class MigratrixAgent < Formula
  desc "Database migration and data transformation agent"
  homepage "https://migratrix.com"
  version "3.2.5"
  
  on_macos do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/3.2.5/migratrix-agent-darwin-amd64.tar.gz"
      sha256 "df3d6a060bee8f8c2d50a463e69b12d83e08314a50847341cdb04ce46d7c2da2"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/3.2.5/migratrix-agent-darwin-arm64.tar.gz"
      sha256 "fd2592f4387140ca1994017aa17a6f2ec11c27bd84710364140f0c608c85cfd9"
    end
  end
  
  on_linux do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/3.2.5/migratrix-agent-linux-amd64.tar.gz"
      sha256 "314a2b1fcd452a3c9c42f3b0c90458636438e5f598769b91c59ccf3d6e41b127"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/3.2.5/migratrix-agent-linux-arm64.tar.gz"
      sha256 "7d9373cdbb6dd3585e09f2a232a46ad3a814fd5198cb138649b849371647d352"
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
