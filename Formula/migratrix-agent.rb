class MigratrixAgent < Formula
  desc "Database migration and data transformation agent"
  homepage "https://migratrix.com"
  version "1.1.8"
  
  on_macos do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.1.8/migratrix-agent-darwin-amd64.tar.gz"
      sha256 "39f875d9b130c549cca65a1f483900c66288a6a782da6beb7f3c6b07eeed5890"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.1.8/migratrix-agent-darwin-arm64.tar.gz"
      sha256 "5c7349bb028285caea07968b03eba951f0d05ea287e23ddd7214a059d7056eb6"
    end
  end
  
  on_linux do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.1.8/migratrix-agent-linux-amd64.tar.gz"
      sha256 "85e0101b82baaa4ff1152156c90dfbc60a632b02f1e5e8104cbf359fcc3af1e3"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.1.8/migratrix-agent-linux-arm64.tar.gz"
      sha256 "5fb755432749d47ca8805dbbcb0d8bb44c029274391b40db99ff53ba1b3e879a"
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
