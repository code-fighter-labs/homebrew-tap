class MigratrixAgent < Formula
  desc "Database migration and data transformation agent"
  homepage "https://migratrix.com"
  version "2.0.0"
  
  on_macos do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/2.0.0/migratrix-agent-darwin-amd64.tar.gz"
      sha256 "6bf5998992b79787991d1fa897af18002c3516582a45acfa09df2a7b1bffc399"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/2.0.0/migratrix-agent-darwin-arm64.tar.gz"
      sha256 "eb5c24295313b79b25538bf3378cf396b5ef57fe7d997f18f9882a99dc9de229"
    end
  end
  
  on_linux do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/2.0.0/migratrix-agent-linux-amd64.tar.gz"
      sha256 "54e0d51b1d4217bc4c7146c49d862ca9fc5def6fe58bf4bb729d5a2da50b92e4"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/2.0.0/migratrix-agent-linux-arm64.tar.gz"
      sha256 "e11d63d19d55dae82c61d98489b32ea69531a632d814f90da41a7a62872dbc15"
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
