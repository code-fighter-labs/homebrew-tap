class MigratrixAgent < Formula
  desc "Database migration and data transformation agent"
  homepage "https://migratrix.com"
  version "2.0.11"
  
  on_macos do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/2.0.11/migratrix-agent-darwin-amd64.tar.gz"
      sha256 "6b16e8d61ea380652995a0412d893d26a217143e52cb05d3934eafa67c7389ba"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/2.0.11/migratrix-agent-darwin-arm64.tar.gz"
      sha256 "eb18ea024f10cf2b175df4710ae89924c3faca2761ea78c7b6a33a5e4d73358a"
    end
  end
  
  on_linux do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/2.0.11/migratrix-agent-linux-amd64.tar.gz"
      sha256 "2f5bdf8a651eb8cf1b5ee13b58eb0ac0bfaca7b3c1182300194c9ed56180ab52"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/2.0.11/migratrix-agent-linux-arm64.tar.gz"
      sha256 "0ae32708ac0ec0125211ea143466cccf497785243195a16697e05fdddbcd55f7"
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
