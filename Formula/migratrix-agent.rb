class MigratrixAgent < Formula
  desc "Database migration and data transformation agent"
  homepage "https://migratrix.com"
  version "5.5.7"
  
  on_macos do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/5.5.7/migratrix-agent-darwin-amd64.tar.gz"
      sha256 "339ada36243a0f6cac9d6340c2fc52b571110c909bd682dc0619d7d602dbcab9"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/5.5.7/migratrix-agent-darwin-arm64.tar.gz"
      sha256 "28077e8aa845b0f6a48f07d48c5eb0b24a14dffb7867d2f7c59b9188432bf458"
    end
  end
  
  on_linux do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/5.5.7/migratrix-agent-linux-amd64.tar.gz"
      sha256 "61ddea5d5382c7732221c375551130617d097737beb50c907ce2727dfca7aed2"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/5.5.7/migratrix-agent-linux-arm64.tar.gz"
      sha256 "175c62a9b5d1a50c30443b34974776857335aabedf4cb3e3cfd9d11188aadd77"
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
