class MigratrixAgent < Formula
  desc "Database migration and data transformation agent"
  homepage "https://migratrix.com"
  version "2.0.14"
  
  on_macos do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/2.0.14/migratrix-agent-darwin-amd64.tar.gz"
      sha256 "5483a493aef659f8821b210cbf0fce2687f651afc89f65d2392c7dba78fc0f7d"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/2.0.14/migratrix-agent-darwin-arm64.tar.gz"
      sha256 "e56a0e405925bca0c8d4af821247842069afdf90414d2f602b88feffa0074fa0"
    end
  end
  
  on_linux do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/2.0.14/migratrix-agent-linux-amd64.tar.gz"
      sha256 "447c67143e7e94bc0e40c3ee74016ebe75eb87bb739565d3ee928318cce9f27a"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/2.0.14/migratrix-agent-linux-arm64.tar.gz"
      sha256 "bd7247ff0ec3951090fa0fb3b600c20ae99c85bd868c39593ee8f07e272e44bf"
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
