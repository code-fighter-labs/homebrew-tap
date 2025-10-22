class MigratrixAgent < Formula
  desc "Database migration and data transformation agent"
  homepage "https://migratrix.com"
  version "2.0.7"
  
  on_macos do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/2.0.7/migratrix-agent-darwin-amd64.tar.gz"
      sha256 "405ce938d720511235a237a29fa85ab2c25f1f8e794fb13806bcb01ea2840064"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/2.0.7/migratrix-agent-darwin-arm64.tar.gz"
      sha256 "6eca065c8ab232f09d4a8e005421060fabf0a4544e7e83ac503e66a50eb00fce"
    end
  end
  
  on_linux do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/2.0.7/migratrix-agent-linux-amd64.tar.gz"
      sha256 "beaa646586f005648e7be0fda5254eb9833f1ba16f83efff5f85c8365a2df646"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/2.0.7/migratrix-agent-linux-arm64.tar.gz"
      sha256 "56edbafcc21e814ee07d7b0d27fde87e28161ad22a22cf788e78569260fd0443"
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
