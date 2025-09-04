class MigratrixAgent < Formula
  desc "Database migration and data transformation agent"
  homepage "https://migratrix.com"
  version "1.1.17"
  
  on_macos do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.1.17/migratrix-agent-darwin-amd64.tar.gz"
      sha256 "782c0e8c87a00bfbc5f86fff01fda8d86d35739b8ce743f33ba16dcc7a611b3c"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.1.17/migratrix-agent-darwin-arm64.tar.gz"
      sha256 "b312ff60c454761be4d68f736b2c7b401d5c710108e40789d0f84ea63e6621b1"
    end
  end
  
  on_linux do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.1.17/migratrix-agent-linux-amd64.tar.gz"
      sha256 "4d7dc166cfd05b032b924239e0b1ecf9cf9184c39cd9e76e01b40a52cbc3d833"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.1.17/migratrix-agent-linux-arm64.tar.gz"
      sha256 "fb612844493d38d6626911cd5b1434329c3b1b3362cfd3aa0c4a9506d942245b"
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
