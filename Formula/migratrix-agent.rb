class MigratrixAgent < Formula
  desc "Database migration and data transformation agent"
  homepage "https://migratrix.com"
  version "1.0.26"
  
  on_macos do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.0.26/migratrix-agent-darwin-amd64.tar.gz"
      sha256 "b685b865bb95c7bc9a077f37a71afb45b58b04529a829ec5454da10a1e389d7a"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.0.26/migratrix-agent-darwin-arm64.tar.gz"
      sha256 "0b9507a9dba82459ac8fca5e855355fb1b6e77057ae4b7b7f436dba6c80bc2ca"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.0.26/migratrix-agent-linux-amd64.tar.gz"
      sha256 "719180d07c70c60be3cc361b813cd1d717c47d1fa7801281581251214e3c204d"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.0.26/migratrix-agent-linux-arm64.tar.gz"
      sha256 "7a9458dda78421cfd48de242cee2fb3aaa75e301e6dc16438260542ce5185c35"
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
