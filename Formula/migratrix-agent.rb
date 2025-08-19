class MigratrixAgent < Formula
  desc "Database migration and data transformation agent"
  homepage "https://migratrix.com"
  version "1.0.14"
  
  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/#{version}/migratrix-agent-darwin-arm64.tar.gz"
      sha256 "4b01c490ea3c41be3b71c9961101c6730c32c2d4f93693d46f2e1bff6ae9ecad"
    else
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/#{version}/migratrix-agent-darwin-amd64.tar.gz"
      sha256 "3b3c650fd52ad6e990f10130aed0bbbd80917300995717beb0906b8819754a52"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/#{version}/migratrix-agent-linux-arm64.tar.gz"
      sha256 "e653a81450a61cf09012d7738a91afb95ae1b71bdfc19d4ff8da9a8fef2ea9ef"
    else
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/#{version}/migratrix-agent-linux-amd64.tar.gz"
      sha256 "c23691edeac523f9d6150f5ca7c50c2c04125f35f7015bc11c9f999e40d64d2d"
    end
  end

  def install
    bin.install "migratrix-agent"
  end

  test do
    system "#{bin}/migratrix-agent", "--version"
    assert_match version.to_s, shell_output("#{bin}/migratrix-agent --version")
  end
end
