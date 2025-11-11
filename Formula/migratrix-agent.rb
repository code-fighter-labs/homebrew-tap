class MigratrixAgent < Formula
  desc "Database migration and data transformation agent"
  homepage "https://migratrix.com"
  version "2.0.17"
  
  on_macos do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/2.0.17/migratrix-agent-darwin-amd64.tar.gz"
      sha256 "7d59534993ef4b69946acb7cd94c3d7e5fd3a14847df47c83e5343e5586af366"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/2.0.17/migratrix-agent-darwin-arm64.tar.gz"
      sha256 "9823ccd945c0d8f4b12bb253c42e9a817053e4de5cbec7f8844a9bd0ee1b80f9"
    end
  end
  
  on_linux do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/2.0.17/migratrix-agent-linux-amd64.tar.gz"
      sha256 "12a4619bdd154ddcac1765760f5ee1a3f2ab8c3d6eb93b58f0a5c179153c0188"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/2.0.17/migratrix-agent-linux-arm64.tar.gz"
      sha256 "fdf899975bf4f4e49e4615b75b96b4ce5e1bf646436ed6cab90d9a23ff290784"
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
