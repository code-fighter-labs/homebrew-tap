class MigratrixAgent < Formula
  desc "Database migration and data transformation agent"
  homepage "https://migratrix.com"
  version "2.1.1"
  
  on_macos do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/2.1.1/migratrix-agent-darwin-amd64.tar.gz"
      sha256 "884ec24c92b6d2d341c5bb8413ec711d57893223fd46e05b43f63ec1e35f299d"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/2.1.1/migratrix-agent-darwin-arm64.tar.gz"
      sha256 "be4c7f7948f5305e2ec35a5a33056cd0dba584ec99d8de59215ba294d23bf20e"
    end
  end
  
  on_linux do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/2.1.1/migratrix-agent-linux-amd64.tar.gz"
      sha256 "b238220b451b7c70a9013afa86ba7ba4f69431c63c54577fecdada2970678930"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/2.1.1/migratrix-agent-linux-arm64.tar.gz"
      sha256 "3f60d620eb58c585493ef4a7efe574738330cdc127aa82a34a076ac7d17faf00"
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
