class MigratrixAgent < Formula
  desc "Database migration and data transformation agent"
  homepage "https://migratrix.com"
  version "1.0.9"
  
  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/#{version}/migratrix-agent-darwin-arm64.tar.gz"
      sha256 "e26a14d1f77c063a4de070c8892436e361860964846ae7ee7446d0105b01cb95"
    else
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/#{version}/migratrix-agent-darwin-amd64.tar.gz"
      sha256 "43b25d23b66542fa1f52ad1c79702e42d6d6f0425526b1729094e548b542cf38"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/#{version}/migratrix-agent-linux-arm64.tar.gz"
      sha256 "081221c8012cd873d530f88079ee96cb0cab0458d4d34558730f29e5cc1ac945"
    else
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/#{version}/migratrix-agent-linux-amd64.tar.gz"
      sha256 "73e9183f803bb3a149d7af3ace72360cb6850d2a98767f769d65ac12d3d31967"
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
