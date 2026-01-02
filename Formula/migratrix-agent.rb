class MigratrixAgent < Formula
  desc "Database migration and data transformation agent"
  homepage "https://migratrix.com"
  version "5.5.8"
  
  on_macos do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/5.5.8/migratrix-agent-darwin-amd64.tar.gz"
      sha256 "0cdbba0a3f3116f2ebb17093d857ada77c725f6bcadeaff2b9179596aae4e76f"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/5.5.8/migratrix-agent-darwin-arm64.tar.gz"
      sha256 "45fed6a190ae73d9e85aed957fea95a450b89fc036f021ac2fde40f88bb961f3"
    end
  end
  
  on_linux do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/5.5.8/migratrix-agent-linux-amd64.tar.gz"
      sha256 "e5b7b56569d3b7bf18812b5ddbfa1ba64c67cdc8a56c1c2c45226237eb9b8991"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/5.5.8/migratrix-agent-linux-arm64.tar.gz"
      sha256 "ee553aff694e7db4ca473ff108b99503f9eb1ddd965431c3ca8dcf1aa3ecb161"
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
