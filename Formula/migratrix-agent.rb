class MigratrixAgent < Formula
  desc "Database migration and data transformation agent"
  homepage "https://migratrix.com"
  version "0.0.8"
  
  on_macos do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/0.0.8/migratrix-agent-darwin-amd64.tar.gz"
      sha256 "fa0fa49b0da0373f2a06f5581898a551431819997aa8b280fdf5ea9b667008e7"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/0.0.8/migratrix-agent-darwin-arm64.tar.gz"
      sha256 "eac29f04469f0797d8c4780731878ddf260e6a6bf0922723a48a76e1afa0d00f"
    end
  end
  
  on_linux do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/0.0.8/migratrix-agent-linux-amd64.tar.gz"
      sha256 "dc89f4272059cb35caa0dfc182a6cb089f2c1b23dd63c721ea546ec2dabe8620"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/0.0.8/migratrix-agent-linux-arm64.tar.gz"
      sha256 "db9043156ca3e6582a91f4ce0d0f58cdf88d6c806cc6bb12dfe07466fbf2de5c"
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

  def post_install
    if File.exist?("#{libexec}/migratrix-agent") && !File.exist?("#{libexec}/migratrix-agent")
      system "mv", "#{libexec}/migratrix-agent", "#{libexec}/migratrix-agent"
    end
  end
