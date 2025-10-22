class MigratrixAgent < Formula
  desc "Database migration and data transformation agent"
  homepage "https://migratrix.com"
  version "2.0.5"
  
  on_macos do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/2.0.5/migratrix-agent-darwin-amd64.tar.gz"
      sha256 "96432480136fc339a9a68486a1eeb0b2bf1defe3cab3c3e61fa4b22c622061a6"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/2.0.5/migratrix-agent-darwin-arm64.tar.gz"
      sha256 "f6be22a16a7b589770fb3dae33a965a032b56d9fc339ef66236b9204be12b256"
    end
  end
  
  on_linux do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/2.0.5/migratrix-agent-linux-amd64.tar.gz"
      sha256 "776924a1c4ad0991d713615dd58dff920baa0ce46d936a1f946484e03878e1bb"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/2.0.5/migratrix-agent-linux-arm64.tar.gz"
      sha256 "4e4f21e91870f9d0d8f73392107f0e4515038c129589c52e0af22fcb0f1ff8d9"
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
