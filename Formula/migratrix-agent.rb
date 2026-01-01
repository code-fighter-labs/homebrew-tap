class MigratrixAgent < Formula
  desc "Database migration and data transformation agent"
  homepage "https://migratrix.com"
  version "5.5.5"
  
  on_macos do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/5.5.5/migratrix-agent-darwin-amd64.tar.gz"
      sha256 "646e188f377a6e91d57bdd7bd17a8f0ab151aa3637d1f28e2d5264ae1fb63b5c"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/5.5.5/migratrix-agent-darwin-arm64.tar.gz"
      sha256 "6fce8c968d8de1b57e2b81f44fa1403e55ea7551785a25216b59dede1b90c0b6"
    end
  end
  
  on_linux do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/5.5.5/migratrix-agent-linux-amd64.tar.gz"
      sha256 "a2f11de6d7dbc223bf15c380cc15c6a3b5f75dd6c7a2e11bb13fb673b038f5ed"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/5.5.5/migratrix-agent-linux-arm64.tar.gz"
      sha256 "ed7f12c1f498271a764cfdd3cb2b7c4e8ff15d71920d42bc4c8a27dfa7973f18"
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
