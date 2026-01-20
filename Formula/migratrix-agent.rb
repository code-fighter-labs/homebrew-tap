class MigratrixAgent < Formula
  desc "Database migration and data transformation agent"
  homepage "https://migratrix.com"
  version "0.0.3"
  
  on_macos do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/0.0.3/migratrix-agent-darwin-amd64.tar.gz"
      sha256 "a6ab47fa003b1cc7ee3088138267365c18810afe249af5666fca5d72a2b6b547"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/0.0.3/migratrix-agent-darwin-arm64.tar.gz"
      sha256 "de36017e0330b091395ce1df70eb56f12e1eac59292e8c2da7caeb544d19f730"
    end
  end
  
  on_linux do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/0.0.3/migratrix-agent-linux-amd64.tar.gz"
      sha256 "a5d3d09ac1e000c7dd00c7eb5f2cb45c0f97b3ad1821e0df26e1292ceb6f5f89"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/0.0.3/migratrix-agent-linux-arm64.tar.gz"
      sha256 "1c10d7cd16bda26281878bfa3a2b103fd31a0f29ce934022a6f6d39f96397312"
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

  def post_install
    if File.exist?("#{libexec}/migratrix-agent") && !File.exist?("#{libexec}/migratrix-agent")
      system "mv", "#{libexec}/migratrix-agent", "#{libexec}/migratrix-agent"
    end
  end
