class MigratrixAgent < Formula
  desc "Database migration and data transformation agent"
  homepage "https://migratrix.com"
  version "1.0.33"
  
  on_macos do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.0.33/migratrix-agent-darwin-amd64.tar.gz"
      sha256 "f5ae89f7d37279b61aac8670d9e20614ead265bcd7f5563b335570e69154c208"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.0.33/migratrix-agent-darwin-arm64.tar.gz"
      sha256 "dce8f9bc1dbab79f16a85053484ccac4a44419ab157b23dcda2e53d2e1f60acc"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.0.33/migratrix-agent-linux-amd64.tar.gz"
      sha256 "58cad86769ae6cce9b4f1a34968ada574d34c38a4f4e3deae77917c01968410f"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.0.33/migratrix-agent-linux-arm64.tar.gz"
      sha256 "85e0fe35374b67bd4811a85e70b777bfab1ceea6bdd4252b8e48f128be7d59ab"
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
