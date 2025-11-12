class MigratrixAgent < Formula
  desc "Database migration and data transformation agent"
  homepage "https://migratrix.com"
  version "2.1.0"
  
  on_macos do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/2.1.0/migratrix-agent-darwin-amd64.tar.gz"
      sha256 "4baa8575e6e1144b9e3c496246144af183dbccf10abd4cc90df35ceed7ac1fb0"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/2.1.0/migratrix-agent-darwin-arm64.tar.gz"
      sha256 "6d2c99a2164041a58f8728583f0446981f0141e5ec0a88d05bd3789bb3c6466a"
    end
  end
  
  on_linux do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/2.1.0/migratrix-agent-linux-amd64.tar.gz"
      sha256 "246c70156b78fd8a17189736fd344f1f11096be513d4a76b866c67725635f711"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/2.1.0/migratrix-agent-linux-arm64.tar.gz"
      sha256 "1fa47ea96e79042e70d8519c6646719a46ec0301c18fe9454c79a62194df2f52"
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
