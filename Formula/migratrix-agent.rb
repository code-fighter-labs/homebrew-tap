class MigratrixAgent < Formula
  desc "Database migration and data transformation agent"
  homepage "https://migratrix.com"
  version "1.0.18"
  
  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/#{version}/migratrix-agent-darwin-arm64.tar.gz"
      sha256 "8053adda1acb9702f3182f09a28535a585960ab75999ab81d3d95cefa3e44203"
    else
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/#{version}/migratrix-agent-darwin-amd64.tar.gz"
      sha256 "4e191bba85e3f15a14afced300ccad90019b553f7553ba3d69a9b6b97886b817"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/#{version}/migratrix-agent-linux-arm64.tar.gz"
      sha256 "e5105c2334f3bf09fde3801756f706850c4951e0ddafaaebc7d4e04296905412"
    else
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/#{version}/migratrix-agent-linux-amd64.tar.gz"
      sha256 "8bfec00237efc6971e86b9984a4bc0a6e86d4b83c797dc5ca764bcd42dba671c"
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
