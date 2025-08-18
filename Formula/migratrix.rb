# Formula/migratrix.rb
# This goes in a separate repository: migratrix/homebrew-tap

class Migratrix < Formula
  desc "Database migration and data transformation tool"
  homepage "https://migratrix.com"
  version "1.0.0"  # Update this with each release
  
  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/migratrix/migratrix/releases/download/v#{version}/migratrix-darwin-arm64.tar.gz"
      sha256 "put_arm64_sha256_here"  # Get from checksums.txt in release
    else
      url "https://github.com/migratrix/migratrix/releases/download/v#{version}/migratrix-darwin-amd64.tar.gz"
      sha256 "put_amd64_sha256_here"  # Get from checksums.txt in release
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/migratrix/migratrix/releases/download/v#{version}/migratrix-linux-arm64.tar.gz"
      sha256 "put_linux_arm64_sha256_here"
    else
      url "https://github.com/migratrix/migratrix/releases/download/v#{version}/migratrix-linux-amd64.tar.gz"
      sha256 "put_linux_amd64_sha256_here"
    end
  end

  def install
    bin.install "migratrix"
    
    # Optional: Install completion scripts
    # generate_completions_from_executable(bin/"migratrix", "completion")
    
    # Optional: Install man pages
    # man1.install "docs/migratrix.1" if File.exist?("docs/migratrix.1")
  end

  test do
    # Test that the binary runs
    system "#{bin}/migratrix", "--version"
    assert_match version.to_s, shell_output("#{bin}/migratrix --version")
  end
end