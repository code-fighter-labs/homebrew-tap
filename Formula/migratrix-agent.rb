class MigratrixAgent < Formula
  desc "Database migration and data transformation agent"
  homepage "https://migratrix.com"
  version "0.0.7"
  
  on_macos do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/0.0.7/migratrix-agent-darwin-amd64.tar.gz"
      sha256 "a72cc752d6dd2ea0eda29a1c97c670ea3362769ebb4827b3dc936e0b6cab0969"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/0.0.7/migratrix-agent-darwin-arm64.tar.gz"
      sha256 "8f1be14fae467d168d8da4c359684638f35a7528ee8f0bef311af8cfad7a1230"
    end
  end
  
  on_linux do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/0.0.7/migratrix-agent-linux-amd64.tar.gz"
      sha256 "9ff7e0d18b58889a2dd369385b539bfcd62a7913571af69e92c7f266ab2b0a6a"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/0.0.7/migratrix-agent-linux-arm64.tar.gz"
      sha256 "4397e40f30a4e8817bd0b78a042a7c03340c2f93ac1aa520ee2759728eff7f95"
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
