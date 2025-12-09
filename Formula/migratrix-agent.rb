class MigratrixAgent < Formula
  desc "Database migration and data transformation agent"
  homepage "https://migratrix.com"
  version "3.1.2"
  
  on_macos do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/3.1.2/migratrix-agent-darwin-amd64.tar.gz"
      sha256 "e4e2b6159d9e398e140a34209df6736e3e494f3da4889e2bc12e732c1fa9890c"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/3.1.2/migratrix-agent-darwin-arm64.tar.gz"
      sha256 "a2725860831c341805440bbe674bb624c085757ca73728d6ef7b5c52d3590b00"
    end
  end
  
  on_linux do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/3.1.2/migratrix-agent-linux-amd64.tar.gz"
      sha256 "e6448275cfd12c36564da40f1486bc5fb5a68979ba55450a5a56eddfa831f2ed"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/3.1.2/migratrix-agent-linux-arm64.tar.gz"
      sha256 "cb584353b9e5bc064183dcbee34a6c198a4e97d2de6e10eda803bcf838e43a11"
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
