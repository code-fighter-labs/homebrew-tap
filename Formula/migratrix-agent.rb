class MigratrixAgent < Formula
  desc "Database migration and data transformation agent"
  homepage "https://migratrix.com"
  version "1.4.5"

  on_macos do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.4.5/migratrix-agent-darwin-amd64.tar.gz"
      sha256 "ad6fd42cd7bc71770c1c84b2eb912f19f15c996edbe87d723a753c089a721954"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.4.5/migratrix-agent-darwin-arm64.tar.gz"
      sha256 "d22c301030d91d45c4a1f348931a9a69aca451c74a4178f8cbf8393d14a70918"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.4.5/migratrix-agent-linux-amd64.tar.gz"
      sha256 "49cd4f3f0b79ccfd34616c4ac503922602842fe01202df28d6822b1473be63e7"
    end
    on_arm do
      url "https://github.com/code-fighter-labs/homebrew-tap/releases/download/1.4.5/migratrix-agent-linux-arm64.tar.gz"
      sha256 "e1e03348aad674e0ec1c429dd66ab5f5a6456bfe52ca56205d985fcf34cd4c21"
    end
  end

  def install
    if OS.mac?
      # macOS: framework-dependent .NET layout. Keep the binary plus all its
      # DLLs together in libexec, expose a thin wrapper in bin so users (and
      # the launchd plist) have a single stable path.
      libexec.install Dir["*"]

      (bin/"migratrix-agent").write <<~EOS
        #!/bin/bash
        exec "#{libexec}/migratrix-agent" "$@"
      EOS
      chmod 0755, bin/"migratrix-agent"
    else
      # Linux: self-contained single-file binary.
      bin.install "migratrix-agent"
    end
  end

  # Runs after `brew install` AND `brew upgrade`. Refreshes the launchd-managed
  # copy under ~/Applications/Migratrix so the service actually runs the new
  # version. Without this, brew updates the cellar but launchd keeps
  # re-launching the stale binary in the user's home dir.
  #
  # Two practical gotchas this block has to work around:
  #
  #   1. Homebrew's post_install runs inside a sandbox that BLOCKS writes
  #      to most $HOME paths. .NET's single-file host tries to extract its
  #      bundled native libraries to ~/.net/... and fails. We fix that by
  #      pointing DOTNET_BUNDLE_EXTRACT_BASE_DIR at the formula's var/ dir,
  #      which the sandbox permits.
  #
  #   2. Even with the env var, the sandbox may still deny writes to
  #      ~/Applications/Migratrix and launchctl operations against the
  #      user's LaunchAgent. If the embedded `migratrix-agent upgrade`
  #      call fails for any reason, we fall through and let the user run
  #      it themselves — see the `caveats` block below.
  def post_install
    home = ENV["HOME"]
    return if home.nil? || home.empty?

    plist       = "#{home}/Library/LaunchAgents/com.migratrix.agent.plist"
    install_dir = "#{home}/Applications/Migratrix"

    # Only do anything if the user has actually installed the agent as a
    # service on this machine. A plain `brew install` (no subsequent
    # `migratrix-agent --apiKey ...`) leaves no plist; we should not
    # synthesize one or copy files into a path the user never asked for.
    return unless File.exist?(plist)

    # Give .NET a sandbox-allowed extraction directory.
    extract_dir = "#{var}/migratrix-agent/dotnet-extract"
    mkdir_p extract_dir

    # Preferred path: ask the new binary to upgrade itself. The 1.4.2+ agent
    # implements the `upgrade` command — it stops the service, recopies
    # itself into install_dir, and restarts. If it succeeds we're done.
    upgraded = false
    with_env(
      DOTNET_BUNDLE_EXTRACT_BASE_DIR: extract_dir,
      DOTNET_NOLOGO: "1",
    ) do
      upgraded = system "#{bin}/migratrix-agent", "upgrade"
    end
    return if upgraded

    # Fallback: the running agent is older than 1.4.2 (no `upgrade` cmd) or
    # the call above hit a sandbox restriction. Try the file-shuffle from
    # Ruby. If the sandbox blocks these too, brew will print the error and
    # the caveats block will tell the user how to recover manually.
    return unless File.directory?(install_dir)

    system "launchctl", "unload", plist
    if OS.mac?
      # macOS uses framework-dependent deployment — copy the WHOLE libexec
      # tree on top of install_dir, not just the bin shim. Otherwise the
      # service would launch a wrapper that points back into the cellar
      # (whose path changes on every release; the next brew cleanup breaks
      # the install).
      system "rsync", "-a", "--delete", "#{libexec}/", "#{install_dir}/"
      chmod 0755, "#{install_dir}/migratrix-agent"
    else
      cp "#{bin}/migratrix-agent", "#{install_dir}/migratrix-agent"
      chmod 0755, "#{install_dir}/migratrix-agent"
    end
    system "launchctl", "load", plist
  end

  def caveats
    <<~EOS
      First-time setup:
        migratrix-agent --apiKey YOUR_API_KEY

      If a future `brew upgrade` reports that post_install failed (Homebrew's
      sandbox sometimes blocks writes into your home directory), refresh the
      installed agent yourself:
        migratrix-agent upgrade

      That will stop the service, copy the new binary into
        ~/Applications/Migratrix
      and restart launchd's com.migratrix.agent.
    EOS
  end

  test do
    system "#{bin}/migratrix-agent", "--version"
  end
end
