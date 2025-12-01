class MigratrixAgent < Formula
  desc "Database migration and data transformation agent"
  homepage "https://migratrix.com"
  version "3.0.08"
  
  on_macos do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/3.0.08/migratrix-agent-darwin-amd64.tar.gz"
      sha256 "a2b256518c4891825d109531ef65ca14a6ab7c65d5881c4502f939cb56213334"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/3.0.08/migratrix-agent-darwin-arm64.tar.gz"
      sha256 "129cb6b5ae41134ac710964ae51959687bd3496d895d7dbc5c933e260f9e8992"
    end
  end
  
  on_linux do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/3.0.08/migratrix-agent-linux-amd64.tar.gz"
      sha256 "effe89df84ef43256a153c0f7e4c6556516870efc468b0d602c2c404727392a7"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/3.0.08/migratrix-agent-linux-arm64.tar.gz"
      sha256 "42a48066fd8a5127b0579fdcaeaddd2ef1c6548535f6e5d7d78ce9384a10da12"
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
