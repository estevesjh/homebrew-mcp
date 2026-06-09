class McpAdsArxiv < Formula
  include Language::Python::Virtualenv

  desc "MCP server: read scientific papers from LaTeX source via NASA ADS + arXiv"
  homepage "https://github.com/estevesjh/mcp-ads-arxiv"
  url "https://github.com/estevesjh/mcp-ads-arxiv/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "696513230bfce12fc8e83fdb35b7071aa027538e74376bc61542372bf2b1b463"
  license "MIT"

  depends_on "python@3.11"

  def install
    venv = virtualenv_create(libexec, "python3.11")
    # Install with all dependencies (including git-based mcp-server-ads)
    system libexec/"bin/python", "-m", "pip", "install", "--no-cache-dir", buildpath.to_s
    bin.install_symlink Dir[libexec/"bin/mcp-ads-arxiv"]
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
