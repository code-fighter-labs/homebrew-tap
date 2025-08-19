class MigratrixAgent < Formula
  desc "Database migration and data transformation agent"
  homepage "https://migratrix.com"
  version "1.0.0"
  
  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/code-fighter-labs/migratrix/releases/download/agent-v#{version}/migratrix-agent-darwin-arm64.tar.gz"
      sha256 "b6f9774a6562870adf7ec1b622c7f837192de20c1c09d9e6e06898e8c08903c3"
    else
      url "https://github.com/code-fighter-labs/migratrix/releases/download/agent-v#{version}/migratrix-agent-darwin-amd64.tar.gz"
      sha256 "229a43f4cf140bfb3c67f6103be5e30437f6cd9580c8c2629cfc1ee99888f466"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/code-fighter-labs/migratrix/releases/download/agent-v#{version}/migratrix-agent-linux-arm64.tar.gz"
      sha256 "2199f62655ef5823d73a7a1b5b6e65a3891fd0bd50dd4e1a0c8ae0f92dc8e401"
    else
      url "https://github.com/code-fighter-labs/migratrix/releases/download/agent-v#{version}/migratrix-agent-linux-amd64.tar.gz"
      sha256 "134f198045171cb726c51761fd7cbb15777c59d988b2b495d03b7157a0c93651"
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