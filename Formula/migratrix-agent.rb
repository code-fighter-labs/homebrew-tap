class MigratrixAgent < Formula
  desc "Database migration and data transformation agent"
  homepage "https://migratrix.com"
  version "4.4.3"
  
  on_macos do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/4.4.3/migratrix-agent-darwin-amd64.tar.gz"
      sha256 "227eaaf827d7ff37f09b87f32b85650a475a2f855f83bd23a11d524829e4c62a"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/4.4.3/migratrix-agent-darwin-arm64.tar.gz"
      sha256 "d99172e7df9857539126e332cc59817a8eb0482eed2b96316314212c71c9ffe5"
    end
  end
  
  on_linux do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/4.4.3/migratrix-agent-linux-amd64.tar.gz"
      sha256 "0ab71b14f23d30623e68dcb5d540f35a8767cce3510f6fb5e4d429057efca865"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/4.4.3/migratrix-agent-linux-arm64.tar.gz"
      sha256 "fe37037c710d040e11401bb0dd5c91e6abfc6d8e1eb2747c2d1729b7e74eca40"
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
