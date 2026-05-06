class MigratrixAgent < Formula
  desc "Database migration and data transformation agent"
  homepage "https://migratrix.com"
  version "1.4.2"

  on_macos do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.4.2/migratrix-agent-darwin-amd64.tar.gz"
      sha256 "0450ffa6f94d7b66273a1bc210af1f5b708ab3954e77cfea1f0f14f0798f86e9"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.4.2/migratrix-agent-darwin-arm64.tar.gz"
      sha256 "cd2aac253be649325ae204afa371549b8dbbc5a2253e451c052ca4c4edb9b1d1"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.4.2/migratrix-agent-linux-amd64.tar.gz"
      sha256 "cc60bb0540cb9241a82592d97364c4352203fe54159ca028caa98c714c311021"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.4.2/migratrix-agent-linux-arm64.tar.gz"
      sha256 "efc0d4da77d1184749cc73adf27b6de774ddf2d151895aec27c8d2c82da5e64a"
    end
  end

  def install
    if OS.mac?
      # macOS multi-file deployment: keep the .NET framework-dependent layout
      # together in libexec, expose a thin shim in bin.
      libexec.install Dir["*"]

      (bin/"migratrix-agent").write <<~EOS
        #!/bin/bash
        exec "#{libexec}/migratrix-agent" "$@"
      EOS
      chmod 0755, bin/"migratrix-agent"
    else
      # Linux: single-file self-contained binary
      bin.install "migratrix-agent"
    end
  end

  # Runs after `brew install` AND `brew upgrade`. Refreshes the launchd-managed
  # copy of the agent under ~/Applications/Migratrix so the service actually
  # runs the new version. Without this, brew updates the cellar but launchd
  # keeps re-launching the stale binary in the user's home dir.
  def post_install
    # Find the user actually running brew. When brew is invoked via sudo this
    # is non-trivial — but for `brew upgrade` (the common case) ENV["HOME"]
    # points at the right user.
    home = ENV["HOME"]
    return if home.nil? || home.empty?

    plist       = "#{home}/Library/LaunchAgents/com.migratrix.agent.plist"
    install_dir = "#{home}/Applications/Migratrix"

    # Only do anything if the user has actually installed the agent as a
    # service on this machine. Plain `brew install migratrix-agent` (no
    # subsequent `migratrix-agent --apiKey ...`) leaves no plist and we
    # should not synthesize one.
    return unless File.exist?(plist)

    # Preferred path: ask the new binary to upgrade itself. The 1.4.2+ agent
    # knows the `upgrade` command — it stops the service, recopies itself
    # into install_dir, and restarts. If it succeeds we're done.
    if system "#{bin}/migratrix-agent", "upgrade"
      return
    end

    # Fallback: the running agent is older than 1.4.2 (i.e. doesn't know
    # `upgrade`). Do the copy + restart manually so users upgrading FROM
    # pre-1.4.2 still get a working post_install.
    return unless File.directory?(install_dir)

    system "launchctl", "unload", plist
    if OS.mac?
      # macOS uses framework-dependent deployment — copy the whole libexec
      # tree on top of install_dir, not just the bin shim. Otherwise the
      # service starts a wrapper that points back into the cellar (which
      # changes path on every release).
      system "rsync", "-a", "--delete", "#{libexec}/", "#{install_dir}/"
      chmod 0755, "#{install_dir}/migratrix-agent"
    else
      cp "#{bin}/migratrix-agent", "#{install_dir}/migratrix-agent"
      chmod 0755, "#{install_dir}/migratrix-agent"
    end
    system "launchctl", "load", plist
  end

  test do
    system "#{bin}/migratrix-agent", "--version"
  end
end
