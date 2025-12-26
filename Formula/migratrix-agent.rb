class MigratrixAgent < Formula
  desc "Database migration and data transformation agent"
  homepage "https://migratrix.com"
  version "3.3.0"
  
  on_macos do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/3.3.0/migratrix-agent-darwin-amd64.tar.gz"
      sha256 "a0126da6c64908a806a8f844120f86b0b2c2af05272a6743f5a0c42f1e43dc23"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/3.3.0/migratrix-agent-darwin-arm64.tar.gz"
      sha256 "82b0fd6c3e328ba091bd04f3631dc9e8b7dc9875157ced80eef79b04f16f5709"
    end
  end
  
  on_linux do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/3.3.0/migratrix-agent-linux-amd64.tar.gz"
      sha256 "45464f3d43ae48f7167e25555f7d15300c8715defbd231db76ec545be4a9552d"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/3.3.0/migratrix-agent-linux-arm64.tar.gz"
      sha256 "1d8d519f694a29a283362e55967de3b8a720f41883f00026ad347379f0f4d0cb"
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
