class MigratrixAgent < Formula
  desc "Database migration and data transformation agent"
  homepage "https://migratrix.com"
  version "3.1.1"
  
  on_macos do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/3.1.1/migratrix-agent-darwin-amd64.tar.gz"
      sha256 "4dd67db6d33691327d66bfc5411781cff1385cb0b7824c039ad531b6ece49c34"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/3.1.1/migratrix-agent-darwin-arm64.tar.gz"
      sha256 "ffd8e7157322a5c5b67146c2b689e250b250e8fa201d095221dff071b03cf894"
    end
  end
  
  on_linux do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/3.1.1/migratrix-agent-linux-amd64.tar.gz"
      sha256 "5c23f50bc65e35cea565c9aa58b9a7ed5c8a4f8ac4bb03adfae24cead3caa3fd"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/3.1.1/migratrix-agent-linux-arm64.tar.gz"
      sha256 "71c8e523bd8d98bbda3519d6885a8614ef8919eae700095c15e1a0b310e3821a"
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
