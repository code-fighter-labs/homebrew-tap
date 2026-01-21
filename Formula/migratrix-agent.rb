class MigratrixAgent < Formula
  desc "Database migration and data transformation agent"
  homepage "https://migratrix.com"
  version "1.1.0"
  
  on_macos do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.1.0/migratrix-agent-darwin-amd64.tar.gz"
      sha256 "33337f31698b42ab683225a4d2cb1652b0647630002e852bc34c7e3e8bae9ddc"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.1.0/migratrix-agent-darwin-arm64.tar.gz"
      sha256 "1458ad691496b2493a5822d727f2d8c0a0637030e3e1eceb3dfd3e01e1301c43"
    end
  end
  
  on_linux do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.1.0/migratrix-agent-linux-amd64.tar.gz"
      sha256 "bb0d48096e87fe2366de3c01869584b1661807d557b9095679be10fb4d1f58af"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.1.0/migratrix-agent-linux-arm64.tar.gz"
      sha256 "56984466e230acd14674caff126c328c398a3503e7315e2842099034be25d853"
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
