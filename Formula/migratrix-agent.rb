class MigratrixAgent < Formula
  desc "Database migration and data transformation agent"
  homepage "https://migratrix.com"
  version "1.0.5"
  
  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/code-fighter-labs/migratrix/releases/download/agent-v#{version}/migratrix-agent-darwin-arm64.tar.gz"
      sha256 "13bb30769f6b01419fc713faeac89628bf462323e9512e0865137b7191d4109b"
    else
      url "https://github.com/code-fighter-labs/migratrix/releases/download/agent-v#{version}/migratrix-agent-darwin-amd64.tar.gz"
      sha256 "aa2ca7c421f1e5a4498eae1968ea200e5b2ac535c4e0b81e717f4bb41fb07cbc"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/code-fighter-labs/migratrix/releases/download/agent-v#{version}/migratrix-agent-linux-arm64.tar.gz"
      sha256 "1eb1441bf9ffe4eaf33c78e157a4097b90ed6024e4db5dcc1677b82a092919bb"
    else
      url "https://github.com/code-fighter-labs/migratrix/releases/download/agent-v#{version}/migratrix-agent-linux-amd64.tar.gz"
      sha256 "0eff456c84cb5bdd445b4b3e548b548598c35b3aefdbdf61bf2711c1a16d6156"
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