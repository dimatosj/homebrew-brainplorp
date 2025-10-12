class Brainplorp < Formula
  include Language::Python::Virtualenv

  desc "Workflow automation for TaskWarrior + Obsidian with MCP integration"
  homepage "https://github.com/dimatosj/brainplorp"
  url "https://github.com/dimatosj/brainplorp/archive/refs/tags/v1.6.0.tar.gz"
  sha256 "4fc4802980c9f059c267c62437381d7d2beae941e0a1b231b85ba3c14f1eb54a"
  license "MIT"
  head "https://github.com/dimatosj/brainplorp.git", branch: "master"

  depends_on "python@3.12"
  depends_on "task" # TaskWarrior 3.x

  resource "click" do
    url "https://files.pythonhosted.org/packages/96/d3/f04c7bfcf5c1862a2a5b845c6b2b360488cf47af55dfa79c98f6a6bf98b5/click-8.1.7.tar.gz"
    sha256 "ca9853ad459e787e2192211578cc907e7594e294c7ccc834310722b41b9ca6de"
  end

  resource "pyyaml" do
    url "https://files.pythonhosted.org/packages/cd/e5/af35f7ea75cf72f2cd079c95ee16797de7cd71f29ea7c68ae5ce7be1eda0/PyYAML-6.0.1.tar.gz"
    sha256 "bfdf460b1736c775f2ba9f6a92bca30bc2095067b8a9d77876d1fad6cc3b4a43"
  end

  resource "rich" do
    url "https://files.pythonhosted.org/packages/b3/01/c954e134dc440ab5f96952fe52b4fdc64225530320a910473c1fe270d9aa/rich-13.7.1.tar.gz"
    sha256 "9be308cb1fe2f1f57d67ce99e95af38a1e2bc71ad9813b0e247cf7ffbcc3a432"
  end

  resource "mcp" do
    url "https://files.pythonhosted.org/packages/source/m/mcp/mcp-1.0.0.tar.gz"
    sha256 "dba51ce0b5c6a80e25576f606760c49a91ee90210fed805b530ca165d3bbc9b7"
  end

  resource "html2text" do
    url "https://files.pythonhosted.org/packages/1a/43/e1d53588561e533212117750ee79ad0ba02a41f52a08c1df3396bd466c05/html2text-2024.2.26.tar.gz"
    sha256 "05f8e367d15aaabc96415376776cdd11afd5127a77fce6e36afc60c563ca2c32"
  end

  def install
    # Custom install to avoid --without-pip flag which can hang
    venv = virtualenv_create(libexec, "python3.12")
    venv.pip_install resources
    venv.pip_install_and_link buildpath
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
    assert_match "brainplorp-mcp", shell_output("#{bin}/brainplorp-mcp --version 2>&1", 1)
  end
end
