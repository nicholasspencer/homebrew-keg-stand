class Factoryskills < Formula
  desc "Opinionated CLI for AI agent-driven development with beads"
  homepage "https://github.com/nicholasspencer/factoryskills"
  version "0.4.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://api.github.com/repos/nicholasspencer/factoryskills/releases/assets/416104825",
          headers: [
            "Authorization: Bearer #{ENV["HOMEBREW_GITHUB_API_TOKEN"]}",
            "Accept: application/octet-stream",
          ]
      sha256 "0f3c185fbc7a7ae782cf3010a7aeded394e7d783a6188d013164a1939ef66d38"
    else
      url "https://api.github.com/repos/nicholasspencer/factoryskills/releases/assets/416104827",
          headers: [
            "Authorization: Bearer #{ENV["HOMEBREW_GITHUB_API_TOKEN"]}",
            "Accept: application/octet-stream",
          ]
      sha256 "ab458c80cbc695580774c2d4407e07a8ef2091e17db5048831265561745dd250"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://api.github.com/repos/nicholasspencer/factoryskills/releases/assets/416104826",
          headers: [
            "Authorization: Bearer #{ENV["HOMEBREW_GITHUB_API_TOKEN"]}",
            "Accept: application/octet-stream",
          ]
      sha256 "5eb95c542206d2550c255ce12dbc07341f3605f192c72ae6512f1e3ee4053a12"
    else
      url "https://api.github.com/repos/nicholasspencer/factoryskills/releases/assets/416104824",
          headers: [
            "Authorization: Bearer #{ENV["HOMEBREW_GITHUB_API_TOKEN"]}",
            "Accept: application/octet-stream",
          ]
      sha256 "e4b31a7e9fbb332d4c28e72157e982c81ce1851810d2d913ea111262cff454b4"
    end
  end

  depends_on "gh"

  def install
    bin.install "bin/fs"
    (share/"factoryskills").install "share/factoryskills/skills"
    if Dir.exist?("share/factoryskills/agents")
      (share/"factoryskills").install "share/factoryskills/agents"
    end
  end

  test do
    assert_match "fs v#{version}", shell_output("#{bin}/fs version")
  end
end
