class MigratrixAgent < Formula
  desc "Database migration and data transformation agent"
  homepage "https://migratrix.com"
  version "1.0.2"
  
  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/code-fighter-labs/migratrix/releases/download/agent-v#{version}/migratrix-agent-darwin-arm64.tar.gz"
      sha256 "d71bbeb30897e614a518e3b039e32e04549223517703964f7dbb434969bc7b63"
    else
      url "https://github.com/code-fighter-labs/migratrix/releases/download/agent-v#{version}/migratrix-agent-darwin-amd64.tar.gz"
      sha256 "03dbedc487049ca5985a3037127224b12615b6af406c6cdab0b15e3239ead232"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/code-fighter-labs/migratrix/releases/download/agent-v#{version}/migratrix-agent-linux-arm64.tar.gz"
      sha256 "ac9b8d86ec3026b531c4ba9e2f4241e83d71f0289fd4f870476c1fa927ea6271"
    else
      url "https://github.com/code-fighter-labs/migratrix/releases/download/agent-v#{version}/migratrix-agent-linux-amd64.tar.gz"
      sha256 "55a8cd81bdfb2c15aab4e928a7c2028b5c25bc53ccd78a27fc9d4ae541148350"
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