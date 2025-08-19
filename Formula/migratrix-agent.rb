class MigratrixAgent < Formula
  desc "Database migration and data transformation agent"
  homepage "https://migratrix.com"
  version "1.0.23"
  
  on_macos do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.0.23/migratrix-agent-darwin-amd64.tar.gz"
      sha256 "007e500a9e568dc2afbacb7cbe900e93a31695d96ae8033c75b3eda7ee9cba66"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.0.23/migratrix-agent-darwin-arm64.tar.gz"
      sha256 "15a8a3bb0e655da205dc82e6ef9a4cb6b22aea933ec4b71357e01aa7c570bd40"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.0.23/migratrix-agent-linux-amd64.tar.gz"
      sha256 "673e3494b74393677d56472dcb7283f101bb82a36992776aa9d8c8e1832f8df2"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.0.23/migratrix-agent-linux-arm64.tar.gz"
      sha256 "9c92583326e0582e58ef44fcfae26f240918dce3800da3d358c928f5a412190c"
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
