class MigratrixAgent < Formula
  desc "Database migration and data transformation agent"
  homepage "https://migratrix.com"
  version "3.1.6"
  
  on_macos do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/3.1.6/migratrix-agent-darwin-amd64.tar.gz"
      sha256 "297cc62ea9756616034998893e816cf1233f105ac4e989746f9dc378cab8d4b9"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/3.1.6/migratrix-agent-darwin-arm64.tar.gz"
      sha256 "46ba966ce7a194f7dd676e53523fd775c7db8f5e050b04a8965b408a522605ab"
    end
  end
  
  on_linux do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/3.1.6/migratrix-agent-linux-amd64.tar.gz"
      sha256 "5ae52b9b55a4ed77b3b75a4c2f1460bb8dfbc7c66b61b1fb14011d86c63cd095"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/3.1.6/migratrix-agent-linux-arm64.tar.gz"
      sha256 "afd3b53639db98dee1e4dfb8a02a65239e43fafbde033b6ae9e8f12c86b38e10"
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
