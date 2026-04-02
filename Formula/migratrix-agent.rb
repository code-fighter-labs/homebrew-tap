class MigratrixAgent < Formula
  desc "Database migration and data transformation agent"
  homepage "https://migratrix.com"
  version "1.3.6"
  
  on_macos do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.3.6/migratrix-agent-darwin-amd64.tar.gz"
      sha256 "c3dd5983626ebe151b4b2c57495675d8c2153ba8d872d00634aee00edf12b670"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.3.6/migratrix-agent-darwin-arm64.tar.gz"
      sha256 "e148313c49d9a19088c9477c20edd9fb94f08b569a82310853279971eb43ace6"
    end
  end
  
  on_linux do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.3.6/migratrix-agent-linux-amd64.tar.gz"
      sha256 "986d1ae4b443288bc56d7d29b29003e31094d39a3a8fd4df4211bdcda2814f54"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.3.6/migratrix-agent-linux-arm64.tar.gz"
      sha256 "fa261b4872700f3d4ed256a1ee7b141000ad032db1f3083d47ec66d876f721ed"
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
