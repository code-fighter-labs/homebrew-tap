class MigratrixAgent < Formula
  desc "Database migration and data transformation agent"
  homepage "https://migratrix.com"
  version "1.0.26"
  
  on_macos do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.0.26/migratrix-agent-darwin-amd64.tar.gz"
      sha256 "f9da044b31682b6af023604edfcec4877efad5c139743688cae1acdd7c005842"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.0.26/migratrix-agent-darwin-arm64.tar.gz"
      sha256 "79a4d1968521e8490bd3f462c5746cd4c1e96f607f74f6d2e355765e16568596"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.0.26/migratrix-agent-linux-amd64.tar.gz"
      sha256 "c45b77475d9840764d925a92400b87f82a33416201bb29332bca2aefc8225e05"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.0.26/migratrix-agent-linux-arm64.tar.gz"
      sha256 "a67f70654a9b578923a2528b6c8316d8d41ca0639b0128eda24b7760ff610670"
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
        exec "#{libexec}/Migratrix.Api.Agent" "$@"
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
