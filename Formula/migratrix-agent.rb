class MigratrixAgent < Formula
  desc "Database migration and data transformation agent"
  homepage "https://migratrix.com"
  version "2.0.16"
  
  on_macos do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/2.0.16/migratrix-agent-darwin-amd64.tar.gz"
      sha256 "82edfdfdbb3e987fa14357ded1972ea24f6790fb659ed43940d74999df68fafa"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/2.0.16/migratrix-agent-darwin-arm64.tar.gz"
      sha256 "ace3a64b63e30ac266c4498f759ff791de38940609c2cd4f172e3303f3f5779b"
    end
  end
  
  on_linux do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/2.0.16/migratrix-agent-linux-amd64.tar.gz"
      sha256 "5702d17d50453e147c936ad501bb82994150b9230e0eea90fff41b26da62739a"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/2.0.16/migratrix-agent-linux-arm64.tar.gz"
      sha256 "b6d58830a1c29a9399a9a7237bc91135599b60bdb46a5afb43520d68059f225e"
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
