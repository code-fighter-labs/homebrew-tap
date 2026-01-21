class MigratrixAgent < Formula
  desc "Database migration and data transformation agent"
  homepage "https://migratrix.com"
  version "0.0.10"
  
  on_macos do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/0.0.10/migratrix-agent-darwin-amd64.tar.gz"
      sha256 "5e04a82a25a18e410698f8d97552abbcc20d38defe30d7317c9171a53e1e77e4"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/0.0.10/migratrix-agent-darwin-arm64.tar.gz"
      sha256 "9ed14949f1c50bc4095aedbb1b8d0e8d07d0c99a1e19c2cbff044488aa65bd8e"
    end
  end
  
  on_linux do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/0.0.10/migratrix-agent-linux-amd64.tar.gz"
      sha256 "6f9a9ca47ec8b1eeb43e21218ed3d00013d7b74aca26c1a8c1880d5ce9ad9529"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/0.0.10/migratrix-agent-linux-arm64.tar.gz"
      sha256 "35388323bafb67ea585ae31fe65390267acd0f85d6a2326dc8ead0b0b0ecbd3a"
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
