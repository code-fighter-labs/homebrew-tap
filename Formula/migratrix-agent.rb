class MigratrixAgent < Formula
  desc "Database migration and data transformation agent"
  homepage "https://migratrix.com"
  version "1.1.16"
  
  on_macos do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.1.16/migratrix-agent-darwin-amd64.tar.gz"
      sha256 "5fe4870ce1c23459017ab7c88aebfea09e53263d9e0d844e1bf5218fa91b19dc"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.1.16/migratrix-agent-darwin-arm64.tar.gz"
      sha256 "1ad34f3102be831dba432c9d9aa11f4910cdf2fe39e159b239a1856905c43841"
    end
  end
  
  on_linux do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.1.16/migratrix-agent-linux-amd64.tar.gz"
      sha256 "2b7610ff81dfda47ccca1f187fddd1c77d51f904b0f7c32f8e63924581dcf229"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.1.16/migratrix-agent-linux-arm64.tar.gz"
      sha256 "55b8fcc6312070a9a59682565e29917d8c69892f508ce10fb874768d0911078e"
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
        exec "#{libexec}/Migratrix.Api.Agent" "$@"
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
