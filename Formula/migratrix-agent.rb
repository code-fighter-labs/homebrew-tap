class MigratrixAgent < Formula
  desc "Database migration and data transformation agent"
  homepage "https://migratrix.com"
  version "5.5.0"
  
  on_macos do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/5.5.0/migratrix-agent-darwin-amd64.tar.gz"
      sha256 "2966473f79ec0f295746ac4d0e42e8bbbb9bfbb10d2aa233b8a862d237c776d4"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/5.5.0/migratrix-agent-darwin-arm64.tar.gz"
      sha256 "f32cad1fb5538deaf86a7630cee5b8c58e3da2babadd739a0f963a9f4b4f6e1c"
    end
  end
  
  on_linux do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/5.5.0/migratrix-agent-linux-amd64.tar.gz"
      sha256 "e2a38b070a80a36011b638cf011f67acfa631d6c29d2ea49fe9ab6b167aa368a"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/5.5.0/migratrix-agent-linux-arm64.tar.gz"
      sha256 "d45eca19de72912e8c3054e60350964bb6a371706b0650d8fcbd9feff8eba4fe"
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
