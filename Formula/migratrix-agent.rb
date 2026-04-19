class MigratrixAgent < Formula
  desc "Database migration and data transformation agent"
  homepage "https://migratrix.com"
  version "1.3.8"
  
  on_macos do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.3.8/migratrix-agent-darwin-amd64.tar.gz"
      sha256 "cb0f0fd0f967667eae9903815203c22003f4b9018d79985a4d6cc617cc095078"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.3.8/migratrix-agent-darwin-arm64.tar.gz"
      sha256 "84813cd9e1e00f66e6e70abbba7a6a3e6fd05a6c99f707a54c827c6b28dda93a"
    end
  end
  
  on_linux do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.3.8/migratrix-agent-linux-amd64.tar.gz"
      sha256 "e9e726f166e36e3789b9baabf33d1e443c772bd02445c3d794770a40ddde4c5c"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.3.8/migratrix-agent-linux-arm64.tar.gz"
      sha256 "3bcfb16546b666b97390fec58a5c96404ab596958d5de99461b1187f2b1e98b5"
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
