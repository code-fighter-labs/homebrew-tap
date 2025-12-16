class MigratrixAgent < Formula
  desc "Database migration and data transformation agent"
  homepage "https://migratrix.com"
  version "3.1.5"
  
  on_macos do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/3.1.5/migratrix-agent-darwin-amd64.tar.gz"
      sha256 "a4001809ef97ea95130ac884061f7e78601c295aa30d11db5cc50a04aa000256"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/3.1.5/migratrix-agent-darwin-arm64.tar.gz"
      sha256 "b8eaf9457f179e1bc53470289c5c40d69c6bb95c34244dec509a34fa4b18e915"
    end
  end
  
  on_linux do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/3.1.5/migratrix-agent-linux-amd64.tar.gz"
      sha256 "4532df41a7104cc1542367df9d49c9f5cb2fd1e539622bb3ebf5267eca9f1210"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/3.1.5/migratrix-agent-linux-arm64.tar.gz"
      sha256 "6244386ec55036162a110cbb248cbe26b94f20bb7ff83be22b608d2331f3a89e"
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
