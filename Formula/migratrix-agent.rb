class MigratrixAgent < Formula
  desc "Database migration and data transformation agent"
  homepage "https://migratrix.com"
  version "3.1.4"
  
  on_macos do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/3.1.4/migratrix-agent-darwin-amd64.tar.gz"
      sha256 "502bb8bd19f3fd5cd67af475d57807254c5c79e704f0e90bc4fa644a7ea3370e"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/3.1.4/migratrix-agent-darwin-arm64.tar.gz"
      sha256 "1e158dd29320d3df0c314862501927d766e8c83a9329efd63bf9f014f2b480d2"
    end
  end
  
  on_linux do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/3.1.4/migratrix-agent-linux-amd64.tar.gz"
      sha256 "dcb2d92d2c3244a8efaeb54538580c6357f47a87d14b69bd6f5c2e450c1abb3c"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/3.1.4/migratrix-agent-linux-arm64.tar.gz"
      sha256 "763cea274e5889a6274c5af17a75f26db205b834ae16040cdb0ff2f1f64a2e31"
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
