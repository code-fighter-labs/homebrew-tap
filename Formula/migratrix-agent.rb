class MigratrixAgent < Formula
  desc "Database migration and data transformation agent"
  homepage "https://migratrix.com"
  version "1.0.41"
  
  on_macos do
    on_intel do
      sha256 "172b003a1839ab756bfc68f8ee9660d4ea8cd62202a201ba36970600b02dca2b"
    end
    on_arm do
      sha256 "4898c147798c5f2eef2ae2cfb4444ff98bdd7dd61883c37e2e292deab8afbe4f"
    end
  end

  on_linux do
    on_intel do
      sha256 "72318f14e450ba7cb61c52067010f93eaaafce2c2982f562ba60121e349be9dc"
    end
    on_arm do
      sha256 "250659df6e2cd4de474cbd809686913a6eaac89d1e28588582d75359be386ba7"
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
