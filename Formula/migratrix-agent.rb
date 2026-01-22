class MigratrixAgent < Formula
  desc "Database migration and data transformation agent"
  homepage "https://migratrix.com"
  version "1.2.0"
  
  on_macos do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.2.0/migratrix-agent-darwin-amd64.tar.gz"
      sha256 "eabc4f93a8f8db20dda15f8bb1585641af664c886e47d367a2351f25906f2e75"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.2.0/migratrix-agent-darwin-arm64.tar.gz"
      sha256 "429be1b67767f8490c139773727026a8c51142db7ad66835c31097882fac4ab5"
    end
  end
  
  on_linux do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.2.0/migratrix-agent-linux-amd64.tar.gz"
      sha256 "c4a8a32b3b24ff7e57a98e376ee6515eb3d8d3de63fd3511ee4a536a5c93752d"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.2.0/migratrix-agent-linux-arm64.tar.gz"
      sha256 "af3e0ffa6fd73cae2f43fe0e0beda264ac56ecf32ed4bd7faa1aaa9067d1de87"
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
