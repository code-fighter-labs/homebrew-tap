class MigratrixAgent < Formula
  desc "Database migration and data transformation agent"
  homepage "https://migratrix.com"
  version "1.0.17"
  
  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/#{version}/migratrix-agent-darwin-arm64.tar.gz"
      sha256 "db62d3d29c088361ebb3c01d9534037f3d5cbb0e78666ede19641db4255c4036"
    else
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/#{version}/migratrix-agent-darwin-amd64.tar.gz"
      sha256 "b8c1b99a9da13ef195b36010de090f0b3ff54297b36e7f409502d73bb701c336"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/#{version}/migratrix-agent-linux-arm64.tar.gz"
      sha256 "0f6a9fd358bd577d1931a433ad97ecb0231b423cca3130a6075b3dfc9fdb65fd"
    else
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/#{version}/migratrix-agent-linux-amd64.tar.gz"
      sha256 "c1a177367a6df33a871436e2563ef785cf5a1ac0ed057a9bda5794cbb29a794c"
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
