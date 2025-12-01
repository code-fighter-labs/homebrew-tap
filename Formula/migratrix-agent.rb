class MigratrixAgent < Formula
  desc "Database migration and data transformation agent"
  homepage "https://migratrix.com"
  version "3.0.10"
  
  on_macos do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/3.0.10/migratrix-agent-darwin-amd64.tar.gz"
      sha256 "d20941d6a9a5f52566f3b6b6de7f2fc7ecc8912dac50e517479c5bfdf125b49a"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/3.0.10/migratrix-agent-darwin-arm64.tar.gz"
      sha256 "054e8282d0a38c566299a864010534b423d6b910db3f718472cb47f63c096fa1"
    end
  end
  
  on_linux do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/3.0.10/migratrix-agent-linux-amd64.tar.gz"
      sha256 "a946e945e7259e2c1fbc294d1693dee41b9518550cd62112c8d916f2c6795712"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/3.0.10/migratrix-agent-linux-arm64.tar.gz"
      sha256 "d23d0c4d9ed7a99f4f62e62ab1723be293238f66548a623d66e50c28687c682d"
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
