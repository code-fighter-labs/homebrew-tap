class MigratrixAgent < Formula
  desc "Database migration and data transformation agent"
  homepage "https://migratrix.com"
  version "3.0.04"
  
  on_macos do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/3.0.04/migratrix-agent-darwin-amd64.tar.gz"
      sha256 "a65ae00392cab9df040ed8b73e80394a8269811b78e1b8e5f9d79184c899ca36"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/3.0.04/migratrix-agent-darwin-arm64.tar.gz"
      sha256 "216470b9ecb21022302c43f18514dcab7093e9be4e370ad1c82bbb0cbb3c0805"
    end
  end
  
  on_linux do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/3.0.04/migratrix-agent-linux-amd64.tar.gz"
      sha256 "e427863f66bdcb5793c1b076db60b097b2f30ee7065bf9c3113652013a82e592"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/3.0.04/migratrix-agent-linux-arm64.tar.gz"
      sha256 "8ca6492847f6c2de0a492d61391f086ea31fde0eeb8f70bf3a7081883b28de64"
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
