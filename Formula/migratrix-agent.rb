class MigratrixAgent < Formula
  desc "Database migration and data transformation agent"
  homepage "https://migratrix.com"
  version "2.0.9"
  
  on_macos do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/2.0.9/migratrix-agent-darwin-amd64.tar.gz"
      sha256 "e8b1a1cad92d419ac14b912ebcda896e7c45cb2614a53b1fecec6166053846ff"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/2.0.9/migratrix-agent-darwin-arm64.tar.gz"
      sha256 "3a3db5a1c175cc7d533019b7478ff89e5c1d2444c8185deddc552927679cb29a"
    end
  end
  
  on_linux do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/2.0.9/migratrix-agent-linux-amd64.tar.gz"
      sha256 "2f745012d59d3c8a4665cab5166e10677772b7edbc88919e3720c39dbe5953e3"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/2.0.9/migratrix-agent-linux-arm64.tar.gz"
      sha256 "2c158e09905c0a3cb62d96c387e785c6381252fa0430e0ce01f6e9bf447356b7"
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
