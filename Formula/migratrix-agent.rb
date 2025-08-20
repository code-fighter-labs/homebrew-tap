class MigratrixAgent < Formula
  desc "Database migration and data transformation agent"
  homepage "https://migratrix.com"
  version "1.0.28"
  
  on_macos do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.0.28/migratrix-agent-darwin-amd64.tar.gz"
      sha256 "cd21691884633dad8208c4d89c5ec983966834a471c2de0eb33ee5420b0eee25"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.0.28/migratrix-agent-darwin-arm64.tar.gz"
      sha256 "d47ea7b31ccf51542abc67ba8e113eb752e7d74bef9c3886c206be07c1f7b2d3"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.0.28/migratrix-agent-linux-amd64.tar.gz"
      sha256 "a8ab2ac0ddfd9363897f581dacb96ed01f781c7917b30dd2652f1b92a4e526cf"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.0.28/migratrix-agent-linux-arm64.tar.gz"
      sha256 "304205d948941a88e437d0347df6785a35747522e573760e203a2ff7ce493290"
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
