class MigratrixAgent < Formula
  desc "Database migration and data transformation agent"
  homepage "https://migratrix.com"
  version "1.0.4"
  
  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/code-fighter-labs/migratrix/releases/download/agent-v#{version}/migratrix-agent-darwin-arm64.tar.gz"
      sha256 "9aad820f0369448c101129cade6448d53d145bd74433dd5eb6b5c160c61e678c"
    else
      url "https://github.com/code-fighter-labs/migratrix/releases/download/agent-v#{version}/migratrix-agent-darwin-amd64.tar.gz"
      sha256 "fe6eba22cca135589321603b7b4f77c6ef8710072087c04e036da81f5449cfca"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/code-fighter-labs/migratrix/releases/download/agent-v#{version}/migratrix-agent-linux-arm64.tar.gz"
      sha256 "209692fde264b5244731fac9d4b735f60cc7e47fc44f0c3565962c7f28e8780d"
    else
      url "https://github.com/code-fighter-labs/migratrix/releases/download/agent-v#{version}/migratrix-agent-linux-amd64.tar.gz"
      sha256 "474ab98ecddaa77c041d006428b513e5a191bcf06f60cd4f659141ba299c87cb"
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