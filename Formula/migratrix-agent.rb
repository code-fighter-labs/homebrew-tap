class MigratrixAgent < Formula
  desc "Database migration and data transformation agent"
  homepage "https://migratrix.com"
  version "1.2.3"
  
  on_macos do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.2.3/migratrix-agent-darwin-amd64.tar.gz"
      sha256 "471d0fcce3dc3e54ffeff6fcf73b35dd30f97ba932634f5bee408693e6aa6eff"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.2.3/migratrix-agent-darwin-arm64.tar.gz"
      sha256 "97d5c647550b2a989714e3af81d571f86643c3f1b4a16a5fd5612b9233dd9142"
    end
  end
  
  on_linux do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.2.3/migratrix-agent-linux-amd64.tar.gz"
      sha256 "92492b5d8a816b998b3d7154a4db0442f581b7fd62b87293bc369853397e53a4"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.2.3/migratrix-agent-linux-arm64.tar.gz"
      sha256 "0b68557aedebd70b498a55f85047316a7f205ab35ce02769e61de826f60f38da"
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
