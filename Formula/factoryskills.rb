class Factoryskills < Formula
  desc "Opinionated CLI for AI agent-driven development with beads"
  homepage "https://github.com/nicholasspencer/factoryskills"
  version "0.1.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/nicholasspencer/factoryskills/releases/download/v0.1.0/factoryskills-0.1.0-darwin-arm64.tar.gz"
      sha256 "5bd02b3c95007b38ac7802ae76dd9009a18354df6444e9b90f37df8175017a6f"
    else
      url "https://github.com/nicholasspencer/factoryskills/releases/download/v0.1.0/factoryskills-0.1.0-darwin-amd64.tar.gz"
      sha256 "b6d49a773611d3330fb2947064da947de52fe177ab7361654910b1ee8b24f1c1"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/nicholasspencer/factoryskills/releases/download/v0.1.0/factoryskills-0.1.0-linux-amd64.tar.gz"
      sha256 "61e8a2dc6752bd524648b7409411b439369c0e6a18c97f7a063138b78aaa16b4"
    end
  end

  depends_on "gh"

  def install
    bin.install "bin/fs"
    (share/"factoryskills").install "share/factoryskills/skills"
  end

  test do
    assert_match "fs #{version}", shell_output("#{bin}/fs version")
  end
end
