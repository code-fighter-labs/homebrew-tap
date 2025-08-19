class MigratrixAgent < Formula
  desc "Database migration and data transformation agent"
  homepage "https://migratrix.com"
  version "1.0.21"
  
  on_macos do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.0.21/migratrix-agent-darwin-amd64.tar.gz"
      sha256 "696dc9ebee78e98be77cff45a3e91003e7af589d819bb7dad24c923fe491f557"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.0.21/migratrix-agent-darwin-arm64.tar.gz"
      sha256 "e80ae68964da629aa16accab28d5e94af43ff52dc8dbd7c61bbc8f1d8197b2e1"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.0.21/migratrix-agent-linux-amd64.tar.gz"
      sha256 "e8a165918d9e13e9700fe1fbe118936524a61b7ddccc86b06aa6abe8cc8ea20f"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.0.21/migratrix-agent-linux-arm64.tar.gz"
      sha256 "fb8010f309490cbdb3a4ebdb5fd4fc997a6bd4fd1376aa97405e1f1de5a15df9"
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
