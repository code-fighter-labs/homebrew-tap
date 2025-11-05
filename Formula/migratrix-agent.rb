class MigratrixAgent < Formula
  desc "Database migration and data transformation agent"
  homepage "https://migratrix.com"
  version "2.0.13"
  
  on_macos do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/2.0.13/migratrix-agent-darwin-amd64.tar.gz"
      sha256 "642ee85d782af2224d1099d76f55883167a3aebe64904eeb1c112ee5532900f4"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/2.0.13/migratrix-agent-darwin-arm64.tar.gz"
      sha256 "27f4571ef72a42d964734b54d4af3c181889ae5010f0784f8ee73d48ca9fc658"
    end
  end
  
  on_linux do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/2.0.13/migratrix-agent-linux-amd64.tar.gz"
      sha256 "cecbced4d02275b0a307f63da6635113d42652d3d713314b407678ab4b2d95a0"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/2.0.13/migratrix-agent-linux-arm64.tar.gz"
      sha256 "142277cf0c096a613532a6a0a92d75b1787012beee3bdfedb9e076b360c798b4"
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
