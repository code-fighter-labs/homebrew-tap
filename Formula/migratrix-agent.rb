class MigratrixAgent < Formula
  desc "Database migration and data transformation agent"
  homepage "https://migratrix.com"
  version "1.0.24"
  
  on_macos do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.0.24/migratrix-agent-darwin-amd64.tar.gz"
      sha256 "47be46cfd82f23ebfd7969ff915bb2142b56a6b63d6995bad74b848a82cc9bcc"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.0.24/migratrix-agent-darwin-arm64.tar.gz"
      sha256 "e2ad38dd22ec94bf46b91f0bef10c5631707f37a7c6a1699b98f8d4ef0fd81d7"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.0.24/migratrix-agent-linux-amd64.tar.gz"
      sha256 "7a0ea318d473f4270f5f3bd0041d2dd53b44f7e827ce55d06b768b8c24df6797"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.0.24/migratrix-agent-linux-arm64.tar.gz"
      sha256 "130276528638449cff7c6ad6fd577728bc8779d9dc32bb78ea2e3b21dba52bbe"
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
