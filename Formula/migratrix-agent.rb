class MigratrixAgent < Formula
  desc "Database migration and data transformation agent"
  homepage "https://migratrix.com"
  version "3.0.06"
  
  on_macos do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/3.0.06/migratrix-agent-darwin-amd64.tar.gz"
      sha256 "93c3756704a60d7c4956e84602bca467a786b40ff66c18b7b6905d0d080524d6"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/3.0.06/migratrix-agent-darwin-arm64.tar.gz"
      sha256 "ce50f19b52bd4970865caa68cd24c47e8bfeaa0894c8cae90ae1152698798e06"
    end
  end
  
  on_linux do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/3.0.06/migratrix-agent-linux-amd64.tar.gz"
      sha256 "315c1009d2f3b5e180567801884228b843ffae03ac397af1bc317a642424aec1"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/3.0.06/migratrix-agent-linux-arm64.tar.gz"
      sha256 "3e03869978de18216d4ae05117e61afb13d5c35c08db3508215eb17f449c715d"
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
