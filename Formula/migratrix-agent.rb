class MigratrixAgent < Formula
  desc "Database migration and data transformation agent"
  homepage "https://migratrix.com"
  version "1.0.32"
  
  on_macos do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.0.32/migratrix-agent-darwin-amd64.tar.gz"
      sha256 "ffdc69d86727cc6526b937068e6e001fd18e34ac5e52032f0b8bf69a278e00c2"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.0.32/migratrix-agent-darwin-arm64.tar.gz"
      sha256 "274d6383280e557c40bd9e3a17478da05000cc74403a2e87c920b8900c1bbb3d"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.0.32/migratrix-agent-linux-amd64.tar.gz"
      sha256 "f3e80414bbad9bbc1abcfa49c40b0ad264580c7d733c3d81b05fa71da0d47dfa"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.0.32/migratrix-agent-linux-arm64.tar.gz"
      sha256 "6a623b82f2f3c2e66cc7a9a819b80c2fb87293bb69b63b89f628697af9155a6e"
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
