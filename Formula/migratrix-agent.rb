class MigratrixAgent < Formula
  desc "Database migration and data transformation agent"
  homepage "https://migratrix.com"
  version "1.3.3"
  
  on_macos do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.3.3/migratrix-agent-darwin-amd64.tar.gz"
      sha256 "1f7594407aa8cbe74416758f46b128888ccd701479c627f5e6d32be4b1563ef4"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.3.3/migratrix-agent-darwin-arm64.tar.gz"
      sha256 "1ae9484eeeda23ddd425224ca36240cb61f6a7c961dc439e697f58726f8db581"
    end
  end
  
  on_linux do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.3.3/migratrix-agent-linux-amd64.tar.gz"
      sha256 "56461a59f2fd0ca1e3fdea0ef0b60be01adbb125782013b6760c5fa19dc88f66"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.3.3/migratrix-agent-linux-arm64.tar.gz"
      sha256 "c6bd75ee473fffca4faaeda2a4afd691165b04b9b67c64e2fe1c028e4b1b1b95"
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
