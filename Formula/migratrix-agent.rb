class MigratrixAgent < Formula
  desc "Database migration and data transformation agent"
  homepage "https://migratrix.com"
  version "2.0.8"
  
  on_macos do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/2.0.8/migratrix-agent-darwin-amd64.tar.gz"
      sha256 "723bf63baba48a9ade5677ffa85ffbaebcbd411b26a4fe7f38c71a18bcee6784"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/2.0.8/migratrix-agent-darwin-arm64.tar.gz"
      sha256 "82aa24c69e4d464e1ecd6ced990b309a96c618b45410d5d02e1ba6dd8a862b0f"
    end
  end
  
  on_linux do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/2.0.8/migratrix-agent-linux-amd64.tar.gz"
      sha256 "59929f4a08387b12a2478d6adf24e53da75d494ce25c22cbf64f8a94d8557d8d"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/2.0.8/migratrix-agent-linux-arm64.tar.gz"
      sha256 "5f0289090116780125e87c576d435f65ba2413f9a2c896a87bd6e2b4278274b3"
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
