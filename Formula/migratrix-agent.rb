class MigratrixAgent < Formula
  desc "Database migration and data transformation agent"
  homepage "https://migratrix.com"
  version "3.1.3"
  
  on_macos do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/3.1.3/migratrix-agent-darwin-amd64.tar.gz"
      sha256 "6e0b4fe22044c450b2e3555df8e7d897061ecd23a1fc4a517804947c9f160648"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/3.1.3/migratrix-agent-darwin-arm64.tar.gz"
      sha256 "6b34eeddc17c011ab128d30901ed1497b5c76b641e11aedeeda905e6bf687802"
    end
  end
  
  on_linux do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/3.1.3/migratrix-agent-linux-amd64.tar.gz"
      sha256 "f22a2769d4ee8b849d1921ce093feaa01a4e1eca543038569f30e19ade056fb0"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/3.1.3/migratrix-agent-linux-arm64.tar.gz"
      sha256 "30696e4de74fcb167e51a29a2cc122c4bae1d9b2ed14c975f63255015281ee1a"
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
