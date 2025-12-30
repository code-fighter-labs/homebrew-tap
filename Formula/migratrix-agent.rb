class MigratrixAgent < Formula
  desc "Database migration and data transformation agent"
  homepage "https://migratrix.com"
  version "5.5.1"
  
  on_macos do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/5.5.1/migratrix-agent-darwin-amd64.tar.gz"
      sha256 "f99a218ed6e388c32221bef6dcb1872922440b909b080fcc8e9315fd882a502a"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/5.5.1/migratrix-agent-darwin-arm64.tar.gz"
      sha256 "bbff96104c029a52707f1fda9e0945690fb469f407cc72b3a0551ad418f3b1f0"
    end
  end
  
  on_linux do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/5.5.1/migratrix-agent-linux-amd64.tar.gz"
      sha256 "f55b619e26af516b62fcc94ba4c4c8d2037d984c85b15aff81c0bc9c5ed8a357"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/5.5.1/migratrix-agent-linux-arm64.tar.gz"
      sha256 "a8b18f5c524f8e73020e8ac20d8f0aa317f358593380ff2e9f9b98826576db9a"
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
