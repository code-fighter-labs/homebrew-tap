class MigratrixAgent < Formula
  desc "Database migration and data transformation agent"
  homepage "https://migratrix.com"
  version "0.0.1"
  
  on_macos do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/0.0.1/migratrix-agent-darwin-amd64.tar.gz"
      sha256 "3925714c70bd3f224ba85e3ad730676a4986e9585c0fbee1ca1fbf8aeec61bfa"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/0.0.1/migratrix-agent-darwin-arm64.tar.gz"
      sha256 "ad998e2eb7835e47889f098882331ed17ebabdc9fb8c166ff72bc72a48908779"
    end
  end
  
  on_linux do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/0.0.1/migratrix-agent-linux-amd64.tar.gz"
      sha256 "00d470f21fea6341b2ed55c1a9d95a89e25c8c89ecf5c3646c98ddf25916cca8"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/0.0.1/migratrix-agent-linux-arm64.tar.gz"
      sha256 "934117a8a800b0171ac032f240dd88857a2a3f936bb40ed7969bc29f2ac7f365"
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
