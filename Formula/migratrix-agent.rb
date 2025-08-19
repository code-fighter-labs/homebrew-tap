class MigratrixAgent < Formula
  desc "Database migration and data transformation agent"
  homepage "https://migratrix.com"
  version "1.0.3"
  
  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/code-fighter-labs/migratrix/releases/download/agent-v#{version}/migratrix-agent-darwin-arm64.tar.gz"
      sha256 "29248ccaba4adf431aa6f7c0b467979b853662c20da1ea86879b4863a3789288"
    else
      url "https://github.com/code-fighter-labs/migratrix/releases/download/agent-v#{version}/migratrix-agent-darwin-amd64.tar.gz"
      sha256 "71adfba8e1f17c291e6c9acf1bf572e07c30164f7a8ccd3a9082d8dc0be63b56"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/code-fighter-labs/migratrix/releases/download/agent-v#{version}/migratrix-agent-linux-arm64.tar.gz"
      sha256 "700510ec86f39b1a666da889d33b36833d2bb7259dee32541d01316f4bc1f8af"
    else
      url "https://github.com/code-fighter-labs/migratrix/releases/download/agent-v#{version}/migratrix-agent-linux-amd64.tar.gz"
      sha256 "3104daa0958482f867ba916736cb808f389187008040a726c32bd1347382fa31"
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