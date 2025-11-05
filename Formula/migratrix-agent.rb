class MigratrixAgent < Formula
  desc "Database migration and data transformation agent"
  homepage "https://migratrix.com"
  version "2.0.10"
  
  on_macos do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/2.0.10/migratrix-agent-darwin-amd64.tar.gz"
      sha256 "6688332cf5b6a7e6c7ab5816072f8e6f916fdfda3564e3eb0fc59682af56bcc9"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/2.0.10/migratrix-agent-darwin-arm64.tar.gz"
      sha256 "246d97422f0d275a4d506f79d096eee479c29a45da26cc73bfbacec2f11a3b21"
    end
  end
  
  on_linux do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/2.0.10/migratrix-agent-linux-amd64.tar.gz"
      sha256 "16715706c54259321d1a70c398e4885c69d916498b683a2964d11e0b57fcfc51"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/2.0.10/migratrix-agent-linux-arm64.tar.gz"
      sha256 "c2eb5089027f0f5661e467c9c9fc1fce99d432e9c60fb715c1f68c43a2e8e383"
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
