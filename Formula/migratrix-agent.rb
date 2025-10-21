class MigratrixAgent < Formula
  desc "Database migration and data transformation agent"
  homepage "https://migratrix.com"
  version "0.0.02"
  
  on_macos do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/0.0.02/migratrix-agent-darwin-amd64.tar.gz"
      sha256 "3bfc800e0837298bb76ae2934386661ffb90630a4aa63f287b941cf8bcfb1e00"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/0.0.02/migratrix-agent-darwin-arm64.tar.gz"
      sha256 "392bf79a9e4105e2039a0666addb4b4dea6d6177e8f919d48b0e534538c7b682"
    end
  end
  
  on_linux do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/0.0.02/migratrix-agent-linux-amd64.tar.gz"
      sha256 "b731248692845299e3caa723a33c0f31b38e16309613e4d753cba30ab9c22cdc"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/0.0.02/migratrix-agent-linux-arm64.tar.gz"
      sha256 "9743af235f85c8be1fc9d09e22aeda2040871dca6a2bdea81c6990ed290646dd"
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
