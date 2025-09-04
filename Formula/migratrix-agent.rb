class MigratrixAgent < Formula
  desc "Database migration and data transformation agent"
  homepage "https://migratrix.com"
  version "1.2.4"
  
  on_macos do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.2.4/migratrix-agent-darwin-amd64.tar.gz"
      sha256 "b590d5335c165043757cd557bed8348ec3658fc75e3630cc5248365713e74c90"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.2.4/migratrix-agent-darwin-arm64.tar.gz"
      sha256 "1ed144fb7c89b793729f699a50613118f029ca24278f7cc373789465693af664"
    end
  end
  
  on_linux do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.2.4/migratrix-agent-linux-amd64.tar.gz"
      sha256 "6d5903caa3f954b65225002e287e162d83d804151123fe8d4b184c15a3d4392f"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.2.4/migratrix-agent-linux-arm64.tar.gz"
      sha256 "dcfaf9e1d48b5541f8e44dc95b4a164635d293edf5bfaa20f3374f2aa9511d58"
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
