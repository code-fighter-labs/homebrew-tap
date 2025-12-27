class MigratrixAgent < Formula
  desc "Database migration and data transformation agent"
  homepage "https://migratrix.com"
  version "3.3.5"
  
  on_macos do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/3.3.5/migratrix-agent-darwin-amd64.tar.gz"
      sha256 "e1e57611615298e8a47c9d8575a165638052c3e89c311b72cec944974a915375"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/3.3.5/migratrix-agent-darwin-arm64.tar.gz"
      sha256 "8be63739a4019f8f34a92e9de804682f97a0c008047484a161b65d01e49b1545"
    end
  end
  
  on_linux do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/3.3.5/migratrix-agent-linux-amd64.tar.gz"
      sha256 "54555ff1f2a59a1b0b6bd58eb6da3aa9df7ba849a279037dc1ec2dfea2dccc9a"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/3.3.5/migratrix-agent-linux-arm64.tar.gz"
      sha256 "ede53af1b7481a257677de40ebfab20245fe83dba9a860f43342c2b3b1ddf424"
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
