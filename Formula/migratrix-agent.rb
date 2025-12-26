class MigratrixAgent < Formula
  desc "Database migration and data transformation agent"
  homepage "https://migratrix.com"
  version "3.2.9"
  
  on_macos do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/3.2.9/migratrix-agent-darwin-amd64.tar.gz"
      sha256 "889429a2d915a6b61d986d199c7aed34b337cad278252e4733cf776964af0d9f"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/3.2.9/migratrix-agent-darwin-arm64.tar.gz"
      sha256 "1ec32de8f424f6faf8c45e0eeb812c463d4658008fc6d0bd62e0e30c49f72dbd"
    end
  end
  
  on_linux do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/3.2.9/migratrix-agent-linux-amd64.tar.gz"
      sha256 "9c450a84bc4a9b2895bdac6feff7d83fd7acbb7e52bb8d6e16f53b916ce08a38"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/3.2.9/migratrix-agent-linux-arm64.tar.gz"
      sha256 "a47f42cef8de1307c99752c35bf455e76d49cbe3489f900f8ab73b6f36339974"
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
