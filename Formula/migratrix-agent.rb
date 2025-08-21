class MigratrixAgent < Formula
  desc "Database migration and data transformation agent"
  homepage "https://migratrix.com"
  version "1.0.42"
  
  on_macos do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.0.42/migratrix-agent-darwin-amd64.tar.gz"
      sha256 "cbb3bbb0832c56bfdf21fd447d46c284b076810f1e9dc7242649a30ef7e14ba5"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.0.42/migratrix-agent-darwin-arm64.tar.gz"
      sha256 "a4a1dae669a3cc5b2dd1e39e130eaebff1fce151b716e0bff109f08f26da54de"
    end
  end
  
  on_linux do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.0.42/migratrix-agent-linux-amd64.tar.gz"
      sha256 "402bc3f2c8ffb6c4f76c4815f21d0dee045fdb134b99c2e77f248a79f3a93ac5"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.0.42/migratrix-agent-linux-arm64.tar.gz"
      sha256 "3a8c872342a1312e0dd63ade2000ecdc8240b416db445b92ba1122f1cbf37df4"
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
