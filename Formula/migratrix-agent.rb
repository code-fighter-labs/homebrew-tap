class MigratrixAgent < Formula
  desc "Database migration and data transformation agent"
  homepage "https://migratrix.com"
  version "4.4.0"
  
  on_macos do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/4.4.0/migratrix-agent-darwin-amd64.tar.gz"
      sha256 "3e0cfbf9270c888c19ac53f13459cfd830c35698649e25372993b60719eb746f"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/4.4.0/migratrix-agent-darwin-arm64.tar.gz"
      sha256 "a603fa3b5f6a1408f3bbe04c3c36607e85de20c2da1ab9dbc04704d1ca07be10"
    end
  end
  
  on_linux do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/4.4.0/migratrix-agent-linux-amd64.tar.gz"
      sha256 "1ee22dfc1d7bda9edc7b7d7f429f09a5801b4da22c2f953bf50cffa8369eb9a7"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/4.4.0/migratrix-agent-linux-arm64.tar.gz"
      sha256 "5ab329054a612a78591ac77810ff3d9b383e486a22f076a7310400d556878e09"
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
