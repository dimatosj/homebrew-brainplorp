class Brainplorp < Formula
  desc "Workflow automation for TaskWarrior + Obsidian with MCP integration"
  homepage "https://github.com/dimatosj/brainplorp"
  url "https://github.com/dimatosj/brainplorp/releases/download/v1.7.1/brainplorp-1.7.1-py3-none-any.whl"
  sha256 "0c05a678e9f03ffcfb092b91b77993ca436eb16f5c3a0b3a2ba1f46eeccc252a"
  license "MIT"
  head "https://github.com/dimatosj/brainplorp.git", branch: "master"

  depends_on "python@3.12"
  depends_on "dimatosj/brainplorp/taskwarrior-pinned" # TaskWarrior 3.4.0 (pinned - 3.4.1 has issues)

  def install
    # Copy wheel to a proper filename (Homebrew caches with hash prefix)
    wheel_file = "brainplorp-#{version}-py3-none-any.whl"
    cp cached_download, wheel_file

    # Install wheel with dependencies (pip reads wheel metadata)
    system Formula["python@3.12"].opt_bin/"pip3.12", "install",
           "--target=#{libexec}",
           "--ignore-installed",
           wheel_file

    # Entry points created at libexec/bin/ by pip
    # Wrap them to set PYTHONPATH
    (bin/"brainplorp").write_env_script(
      libexec/"bin/brainplorp",
      PYTHONPATH: libexec
    )
    (bin/"brainplorp-mcp").write_env_script(
      libexec/"bin/brainplorp-mcp",
      PYTHONPATH: libexec
    )
  end

  def post_install
    ohai "brainplorp #{version} installed successfully!"
    ohai ""
    ohai "Next steps:"
    ohai "  1. Check system health: brainplorp doctor"
    ohai "  2. Configure brainplorp: brainplorp setup"
    ohai "  3. Configure Claude Desktop: brainplorp mcp"
    ohai "  4. Restart Claude Desktop"
    ohai ""
    ohai "Note: TaskWarrior 3.4.0 installed (pinned version)"
    ohai "  - Version 3.4.1 has known issues (hangs on first run)"
    ohai "  - See: github.com/dimatosj/brainplorp#known-issues"
  end

  test do
    assert_match "brainplorp", shell_output("#{bin}/brainplorp --version")
  end
end
