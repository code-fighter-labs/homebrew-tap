class MigratrixAgent < Formula
  desc "Database migration and data transformation agent"
  homepage "https://migratrix.com"
  version "0.0.5"
  
  on_macos do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/0.0.5/migratrix-agent-darwin-amd64.tar.gz"
      sha256 "2e0cd31016243d3625b501ad3d18e806c7b1a063c095ff1e4668d2babe304316"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/0.0.5/migratrix-agent-darwin-arm64.tar.gz"
      sha256 "217e6dc9cbfb74962596ac3d18a14e3645c190e5655654bf46f4982b386e326c"
    end
  end
  
  on_linux do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/0.0.5/migratrix-agent-linux-amd64.tar.gz"
      sha256 "9d55394ccebf96a373157abace1677df5e6f45e339edbd061b2624b2353e1671"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/0.0.5/migratrix-agent-linux-arm64.tar.gz"
      sha256 "62a22be6bf6725da5e9ff828e0d5c22175c607d612c6277a88092d27ed5a0ec9"
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
