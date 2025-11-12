class MigratrixAgent < Formula
  desc "Database migration and data transformation agent"
  homepage "https://migratrix.com"
  version "2.0.18"
  
  on_macos do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/2.0.18/migratrix-agent-darwin-amd64.tar.gz"
      sha256 "139bdcc1e677a925e32188e22c34c76fac1f16c95a3c69bc59246ff19af721f1"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/2.0.18/migratrix-agent-darwin-arm64.tar.gz"
      sha256 "d6f5d928accc81d71200cf95545b7bd30dee6076ce5ac342aafae74c34a2c4f3"
    end
  end
  
  on_linux do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/2.0.18/migratrix-agent-linux-amd64.tar.gz"
      sha256 "df6fa699679e7181499cd5c6c81c4d8fde27f8adb60381a030a0c04610e355bb"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/2.0.18/migratrix-agent-linux-arm64.tar.gz"
      sha256 "81a99dd811785e1e7485f7e8acb80a6b6353f6172c7d0f737cfdb22d23f0f498"
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
