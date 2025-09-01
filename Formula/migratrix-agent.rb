class MigratrixAgent < Formula
  desc "Database migration and data transformation agent"
  homepage "https://migratrix.com"
  version "1.1.10"
  
  on_macos do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.1.10/migratrix-agent-darwin-amd64.tar.gz"
      sha256 "361a5743701a005b51e5d46949f461c8aed75746eb56c1b9ef5ce142cee21b1d"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.1.10/migratrix-agent-darwin-arm64.tar.gz"
      sha256 "4eb28b1fd8dc001877767afda564b9301434a1a2c1582cdc4d91e98c76649420"
    end
  end
  
  on_linux do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.1.10/migratrix-agent-linux-amd64.tar.gz"
      sha256 "9344b78557bcea00a19dd57516895b0336ac273092a219708a7bcb97eb9f33af"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.1.10/migratrix-agent-linux-arm64.tar.gz"
      sha256 "344227dcd32a0ce8e6565130970e67978708948c3fcbb576dfd3a927fe801fc6"
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
