class Factoryskills < Formula
  desc "Opinionated CLI for AI agent-driven development with beads"
  homepage "https://github.com/nicholasspencer/factoryskills"
  version "0.12.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://api.github.com/repos/nicholasspencer/factoryskills/releases/assets/429868750",
          headers: [
            "Authorization: Bearer #{ENV["HOMEBREW_GITHUB_API_TOKEN"]}",
            "Accept: application/octet-stream",
          ]
      sha256 "8ecf2ae5fc100188d4df9c6022644af5b3c2ece9ec9eacfb49820bc77bc6af9e"
    else
      url "https://api.github.com/repos/nicholasspencer/factoryskills/releases/assets/429868748",
          headers: [
            "Authorization: Bearer #{ENV["HOMEBREW_GITHUB_API_TOKEN"]}",
            "Accept: application/octet-stream",
          ]
      sha256 "9300c37073f56f1684270792c24800e2ee986f9816e1f87486334e776d8b9c6b"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://api.github.com/repos/nicholasspencer/factoryskills/releases/assets/429868749",
          headers: [
            "Authorization: Bearer #{ENV["HOMEBREW_GITHUB_API_TOKEN"]}",
            "Accept: application/octet-stream",
          ]
      sha256 "d552036422e10fdde9bd2f38ac98e58184bbdd5926e85d7ae875c239cb5d3540"
    else
      url "https://api.github.com/repos/nicholasspencer/factoryskills/releases/assets/429868747",
          headers: [
            "Authorization: Bearer #{ENV["HOMEBREW_GITHUB_API_TOKEN"]}",
            "Accept: application/octet-stream",
          ]
      sha256 "bb9928e48c2b3c88538dcab1c35389638f376b09d5a7ba818500a2f31cb24fb2"
    end
  end

  depends_on "gh"

  def install
    bin.install "bin/fs"
    (share/"factoryskills").install "share/factoryskills/skills"
    if Dir.exist?("share/factoryskills/agents")
      (share/"factoryskills").install "share/factoryskills/agents"
    end
    if Dir.exist?("share/factoryskills/.beads/formulas")
      (share/"factoryskills/.beads").install "share/factoryskills/.beads/formulas"
    end
  end

  test do
    assert_match "fs v#{version}", shell_output("#{bin}/fs version")
  end
end
