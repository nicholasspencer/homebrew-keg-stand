class Factoryskills < Formula
  desc "Opinionated CLI for AI agent-driven development with beads"
  homepage "https://github.com/nicholasspencer/factoryskills"
  version "0.2.6"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://api.github.com/repos/nicholasspencer/factoryskills/releases/assets/408690833",
          headers: [
            "Authorization: Bearer #{ENV["HOMEBREW_GITHUB_API_TOKEN"]}",
            "Accept: application/octet-stream",
          ]
      sha256 "8c06fa8d61426374f3121ebdd75475d59a790130b4947acf89f93b22bd5e8d0a"
    else
      url "https://api.github.com/repos/nicholasspencer/factoryskills/releases/assets/408690831",
          headers: [
            "Authorization: Bearer #{ENV["HOMEBREW_GITHUB_API_TOKEN"]}",
            "Accept: application/octet-stream",
          ]
      sha256 "5ee895c74dd3727b81470e6f8668fba9b1753a1563415da1c6dd147b2b093e49"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://api.github.com/repos/nicholasspencer/factoryskills/releases/assets/408690832",
          headers: [
            "Authorization: Bearer #{ENV["HOMEBREW_GITHUB_API_TOKEN"]}",
            "Accept: application/octet-stream",
          ]
      sha256 "df8a91ce13e7bf4b4bd6e806dc0598234f8115e0a98a03b864f374fb80fcf6d9"
    end
  end

  depends_on "gh"

  def install
    bin.install "bin/fs"
    (share/"factoryskills").install "share/factoryskills/skills"
    # Bundled subagent definitions landed after v0.2.0; install only when
    # the release tarball actually ships them so older pinned versions
    # keep working.
    if Dir.exist?("share/factoryskills/agents")
      (share/"factoryskills").install "share/factoryskills/agents"
    end
  end

  test do
    assert_match "fs #{version}", shell_output("#{bin}/fs version")
  end
end
