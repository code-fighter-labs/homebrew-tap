class MigratrixAgent < Formula
  desc "Database migration and data transformation agent"
  homepage "https://migratrix.com"
  version "4.4.8"
  
  on_macos do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/4.4.8/migratrix-agent-darwin-amd64.tar.gz"
      sha256 "c4f0238abc6d3aa5f451af30085064adf9065d45dca73b534c463c747f869233"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/4.4.8/migratrix-agent-darwin-arm64.tar.gz"
      sha256 "b2dbacf4f0c6c92b42a82c1ba174a17176ce76a33b54d2b58e96df99affd3425"
    end
  end
  
  on_linux do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/4.4.8/migratrix-agent-linux-amd64.tar.gz"
      sha256 "a33606a7c4aa081c3bd65a27ed2134514b0fee69fac69f4ef0f5f6233f1b6e39"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/4.4.8/migratrix-agent-linux-arm64.tar.gz"
      sha256 "433b59a4375190114a0b872cde4bf4fc4255bd553a9a3f2c46745d6e56f9471e"
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
