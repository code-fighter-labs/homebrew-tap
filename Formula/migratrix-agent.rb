class MigratrixAgent < Formula
  desc "Database migration and data transformation agent"
  homepage "https://migratrix.com"
  version "1.0.15"
  
  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/#{version}/migratrix-agent-darwin-arm64.tar.gz"
      sha256 "8df714759b985dbdf630dffd05cb98b77d8044db603a1f0b9a9f3634b5c691f3"
    else
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/#{version}/migratrix-agent-darwin-amd64.tar.gz"
      sha256 "968c35fb3f4c99e54efaabb517ae9e7442129c5056a11f69785f875379ddfe8e"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/#{version}/migratrix-agent-linux-arm64.tar.gz"
      sha256 "58a854cd4a645ee89a7eddc65a598b0d42044a3dd1d717dbf4ea82ba2133e5e8"
    else
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/#{version}/migratrix-agent-linux-amd64.tar.gz"
      sha256 "3126ef136f6ebacc4e29df7bf967d1f6fdad211d6224a924df86e2420053c047"
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
