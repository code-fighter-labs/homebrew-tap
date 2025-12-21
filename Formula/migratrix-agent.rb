class MigratrixAgent < Formula
  desc "Database migration and data transformation agent"
  homepage "https://migratrix.com"
  version "3.1.11"
  
  on_macos do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/3.1.11/migratrix-agent-darwin-amd64.tar.gz"
      sha256 "411892375c7bcad3a5f17c5442bc1998f3db5002b84d95f0333ecc61a5c682b4"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/3.1.11/migratrix-agent-darwin-arm64.tar.gz"
      sha256 "9de3e37011e1df70343842f8ab31a2d47dff9e0a712d0506cbc3e06d37088b77"
    end
  end
  
  on_linux do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/3.1.11/migratrix-agent-linux-amd64.tar.gz"
      sha256 "75d056d45acc468a103447b111b9016e2ace6ca81d230029297b7c9480079fda"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/3.1.11/migratrix-agent-linux-arm64.tar.gz"
      sha256 "9907c071498eb6ea2332d11793bd4a9c2216d9dab12130995d299aceacc34109"
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
