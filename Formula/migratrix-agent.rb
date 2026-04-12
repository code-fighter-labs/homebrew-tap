class MigratrixAgent < Formula
  desc "Database migration and data transformation agent"
  homepage "https://migratrix.com"
  version "1.3.7"
  
  on_macos do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.3.7/migratrix-agent-darwin-amd64.tar.gz"
      sha256 "23ca708ff13bbfcc71168672a23691fdf3f47370036f839eeb6fc2676245518a"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.3.7/migratrix-agent-darwin-arm64.tar.gz"
      sha256 "dfe0dfc176d22326428032973372fbaf51a88764bee0bb2d5de355cfb698ac89"
    end
  end
  
  on_linux do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.3.7/migratrix-agent-linux-amd64.tar.gz"
      sha256 "56097a7fe0acfb3834d9fa2e6b5c395304b007526004ef79b863fc120d7c5e68"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.3.7/migratrix-agent-linux-arm64.tar.gz"
      sha256 "05529bf1906a8b3df5bfb472592397627f96c1fe8d15235a1e0ead8f793a2d73"
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
