class MigratrixAgent < Formula
  desc "Database migration and data transformation agent"
  homepage "https://migratrix.com"
  version "1.3.2"
  
  on_macos do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.3.2/migratrix-agent-darwin-amd64.tar.gz"
      sha256 "c40eb2884f31e99afa30a2f389ca1e708e367fd58376ae2b3701985fbf8e8f09"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.3.2/migratrix-agent-darwin-arm64.tar.gz"
      sha256 "fc6e8480bd96d48581598bf8da07a31d44f977784c5b49d95e0ce694ce42b230"
    end
  end
  
  on_linux do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.3.2/migratrix-agent-linux-amd64.tar.gz"
      sha256 "787cdc420c52c8fd630aea773ca0d6b8520cb0b21d131788dbee002ecdf95822"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.3.2/migratrix-agent-linux-arm64.tar.gz"
      sha256 "07577a87621c7a27caae25a9600360c5fadc1878962f454a6522344fe5cfa668"
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
