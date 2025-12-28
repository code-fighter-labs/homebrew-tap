class MigratrixAgent < Formula
  desc "Database migration and data transformation agent"
  homepage "https://migratrix.com"
  version "3.3.9"
  
  on_macos do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/3.3.9/migratrix-agent-darwin-amd64.tar.gz"
      sha256 "83c23eca4c6537e1b60a65d22bccf3036f6d31ce838395cd6889b3e2fa619e56"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/3.3.9/migratrix-agent-darwin-arm64.tar.gz"
      sha256 "b68b994eec9253a108d6c6e960698dd0a8b805b3061428d831ccb5fe0bbd3a8f"
    end
  end
  
  on_linux do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/3.3.9/migratrix-agent-linux-amd64.tar.gz"
      sha256 "4340b3b5a35f53715897f94116a87709734205c03848df397afb2e18edf4c199"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/3.3.9/migratrix-agent-linux-arm64.tar.gz"
      sha256 "4d44a19a1586524d996e6e6be13b53a488f448441411501bc03bfe29532337be"
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
