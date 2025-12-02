class MigratrixAgent < Formula
  desc "Database migration and data transformation agent"
  homepage "https://migratrix.com"
  version "3.1.0"
  
  on_macos do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/3.1.0/migratrix-agent-darwin-amd64.tar.gz"
      sha256 "72eb71507841457c18fe241899367a14de46d0b907893be41027bb45c2e2486a"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/3.1.0/migratrix-agent-darwin-arm64.tar.gz"
      sha256 "61ea97ad1b37587074dab7e529029c282299fd80b8f94ef72bed99760f6879e9"
    end
  end
  
  on_linux do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/3.1.0/migratrix-agent-linux-amd64.tar.gz"
      sha256 "35850ff1bd420e1a57213931c40fe128f5fdd26e1cf685c0b8ae4736c6e50f9a"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/3.1.0/migratrix-agent-linux-arm64.tar.gz"
      sha256 "ad066b8830fe543dc158ab77e2e942e8ce7aec69b8a3488372757ed97db648c0"
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
