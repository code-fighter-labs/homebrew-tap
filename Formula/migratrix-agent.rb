class MigratrixAgent < Formula
  desc "Database migration and data transformation agent"
  homepage "https://migratrix.com"
  version "1.1.3"
  
  on_macos do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.1.3/migratrix-agent-darwin-amd64.tar.gz"
      sha256 "d53484650aa973f7810a25c9d312519ee5374bafd712a344c54af9fe22213449"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.1.3/migratrix-agent-darwin-arm64.tar.gz"
      sha256 "c88722e6db0b3eb34127068c890c50b23c1ec639ee4941175b5b25ee3888b49a"
    end
  end
  
  on_linux do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.1.3/migratrix-agent-linux-amd64.tar.gz"
      sha256 "4014800f503c9fb1859a93271ceeec7f9c945c0e248087da9ec0ab91e90994b6"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.1.3/migratrix-agent-linux-arm64.tar.gz"
      sha256 "afcf2a4c804d1014a9bb638bbfc318406dbb1fdf2f2ba0d8e4173a59ad68b5af"
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
