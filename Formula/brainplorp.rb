class Brainplorp < Formula
  desc "Workflow automation for TaskWarrior + Obsidian with MCP integration"
  homepage "https://github.com/dimatosj/brainplorp"
  url "https://github.com/dimatosj/brainplorp/releases/download/v1.7.0/brainplorp-1.7.0-py3-none-any.whl"
  sha256 "fa1bb66a8364aa6f79d9046acea85a8710f632800899986c27d614cf4cca3e9a"
  license "MIT"
  head "https://github.com/dimatosj/brainplorp.git", branch: "master"

  depends_on "python@3.12"
  depends_on "task" # TaskWarrior 3.x

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
    ohai "brainplorp installed successfully!"
    ohai "Next steps:"
    ohai "  1. Run 'brainplorp setup' to configure your installation"
    ohai "  2. Run 'brainplorp mcp' to configure Claude Desktop integration"
    ohai "  3. Restart Claude Desktop to load brainplorp tools"
  end

  test do
    assert_match "brainplorp", shell_output("#{bin}/brainplorp --version")
  end
end
