class McpAdsArxiv < Formula
  include Language::Python::Virtualenv

  desc "MCP server: read scientific papers from LaTeX source via NASA ADS + arXiv"
  homepage "https://github.com/estevesjh/mcp-ads-arxiv"
  url "https://github.com/estevesjh/mcp-ads-arxiv/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "2b7645a8624c9f69d1844e759993e130413665e6c7ff0868aa990bcea18ff1b8"
  license "MIT"

  depends_on "python@3.11"

  def install
    venv = virtualenv_create(libexec, "python3.11")
    venv.pip_install buildpath
    bin.install_symlink libexec/"bin/mcp-ads-arxiv"
  end

  def caveats
    <<~EOS
      To use with Claude Code:

        export ADS_API_TOKEN="your-token"
        export LIT_CACHE_DIR="$HOME/.local/share/mcp-ads-arxiv"
        claude mcp add --scope user mcp-ads-arxiv -- #{opt_bin}/mcp-ads-arxiv

      Get a free ADS token at: https://ui.adsabs.harvard.edu/user/settings/token
      Without a token, the tool still works via the free arXiv API.
    EOS
  end

  test do
    output = shell_output("#{bin}/mcp-ads-arxiv --help 2>&1", 2)
    assert_match "usage", output.downcase
  end
end
