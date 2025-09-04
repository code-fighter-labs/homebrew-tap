class MigratrixAgent < Formula
  desc "Database migration and data transformation agent"
  homepage "https://migratrix.com"
  version "1.2.5"
  
  on_macos do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.2.5/migratrix-agent-darwin-amd64.tar.gz"
      sha256 "68469a6c76beb40f94c499b7713a7f5f85a9e758d55c5458e8c67949a6249b6d"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.2.5/migratrix-agent-darwin-arm64.tar.gz"
      sha256 "f1dbb2220905af0d83d5760684c7c17bf8fa7e9d4616a0cd45a90c445b9be2ed"
    end
  end
  
  on_linux do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.2.5/migratrix-agent-linux-amd64.tar.gz"
      sha256 "05f1d4eda5c8b0f7a236a8e968f66d930c1602cca973f0a626803774fb4206da"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.2.5/migratrix-agent-linux-arm64.tar.gz"
      sha256 "dfbb760111d0f72886592a584f673b220c5574e9dfe73198b30709dd9ecf26b8"
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
