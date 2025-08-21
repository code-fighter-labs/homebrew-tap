class MigratrixAgent < Formula
  desc "Database migration and data transformation agent"
  homepage "https://migratrix.com"
  version "1.0.35"
  
  on_macos do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.0.35/migratrix-agent-darwin-amd64.tar.gz"
      sha256 "d1d2cd917a7887cc3d872ef78864eeaf229bad3b73796f01769308e6e0ff11c1"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.0.35/migratrix-agent-darwin-arm64.tar.gz"
      sha256 "c8b0e8fe2a14dff88129b48e2dd5aca695408ac66f4e788ce1486d34ed056211"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.0.35/migratrix-agent-linux-amd64.tar.gz"
      sha256 "cb31b27c964421ee5eb4b04e397465174b944c9ea7f6a82e491ee479f775dbb3"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.0.35/migratrix-agent-linux-arm64.tar.gz"
      sha256 "76ae25ba4f6661e028e976ede8f157743c542fff8a7d7f1a73774fe268ed8809"
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
