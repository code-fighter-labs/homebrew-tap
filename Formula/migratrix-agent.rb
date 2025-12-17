class MigratrixAgent < Formula
  desc "Database migration and data transformation agent"
  homepage "https://migratrix.com"
  version "3.1.7"
  
  on_macos do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/3.1.7/migratrix-agent-darwin-amd64.tar.gz"
      sha256 "07ef60a58d574d39d07e69ed89981ea1c3a47bf114f895940adaf9b6f037159c"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/3.1.7/migratrix-agent-darwin-arm64.tar.gz"
      sha256 "d9fb29985fe2cacbae99841d2fa8286f922d8cf5d35189979ffb8c7e2034c65d"
    end
  end
  
  on_linux do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/3.1.7/migratrix-agent-linux-amd64.tar.gz"
      sha256 "526c95f2ff46471e6857a6667b054121ac190f2ac3aff70d5ef31d8f953a8b64"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/3.1.7/migratrix-agent-linux-arm64.tar.gz"
      sha256 "8f9d50ef6808b0bab75fd24b215ceccd4b2f17c0ff337a11a4076fb1d6572799"
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
