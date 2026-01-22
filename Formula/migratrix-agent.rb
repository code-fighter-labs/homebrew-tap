class MigratrixAgent < Formula
  desc "Database migration and data transformation agent"
  homepage "https://migratrix.com"
  version "1.2.1"
  
  on_macos do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.2.1/migratrix-agent-darwin-amd64.tar.gz"
      sha256 "fcb2c816f845fb85d7977fe41a9b94bb6b4cda545e4814b6384550de903b2519"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.2.1/migratrix-agent-darwin-arm64.tar.gz"
      sha256 "06468fd64ea843bccde66dbf404d15063c27c7b7cede2d94feea8d500599918d"
    end
  end
  
  on_linux do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.2.1/migratrix-agent-linux-amd64.tar.gz"
      sha256 "78d26f8a3c308a8cbc347fc513e961765804e400da5a9aec393308b7755bc809"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.2.1/migratrix-agent-linux-arm64.tar.gz"
      sha256 "19d6d87ade0c9b61d62f2f0bf7ac32422af2bd12b6fda0474053c5dbc93bd9d9"
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
