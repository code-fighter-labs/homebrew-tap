class MigratrixAgent < Formula
  desc "Database migration and data transformation agent"
  homepage "https://migratrix.com"
  version "3.0.05"
  
  on_macos do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/3.0.05/migratrix-agent-darwin-amd64.tar.gz"
      sha256 "66c5aa5035e7464acf46fb25e9cdd659c77895d7599a17a7aa72d12ea13a30e2"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/3.0.05/migratrix-agent-darwin-arm64.tar.gz"
      sha256 "92c91615766e997fdc4cc8b2c966a8a0c3defa13b05097971e22ca665029c133"
    end
  end
  
  on_linux do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/3.0.05/migratrix-agent-linux-amd64.tar.gz"
      sha256 "4a5c77777991798f1276b3f174848bfbf5640e066fae5b701fb4ca334273fab8"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/3.0.05/migratrix-agent-linux-arm64.tar.gz"
      sha256 "b3ab6dcdfa05e360ee948fbc90ee9a1120f05bbf07251926accc746f3a23053d"
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
