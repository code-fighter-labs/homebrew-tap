class MigratrixAgent < Formula
  desc "Database migration and data transformation agent"
  homepage "https://migratrix.com"
  version "3.1.12"
  
  on_macos do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/3.1.12/migratrix-agent-darwin-amd64.tar.gz"
      sha256 "0e7e0c0176ea1b955c3175756b40035387e53d025c56455819661c2fd46ca170"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/3.1.12/migratrix-agent-darwin-arm64.tar.gz"
      sha256 "a5cd617206cd0c7cf685815ae4ec01874ccd4a84352b9c2f45560d6e2b5db8e2"
    end
  end
  
  on_linux do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/3.1.12/migratrix-agent-linux-amd64.tar.gz"
      sha256 "f886635926f4730b4fc9c5196d85237054d6a1fbe69b71d0aad0dd131d062bbf"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/3.1.12/migratrix-agent-linux-arm64.tar.gz"
      sha256 "4a4c403903bb17faf470063736c36f05b914c6b56a1b60b72bc3f2912c5db698"
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
