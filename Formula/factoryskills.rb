class Factoryskills < Formula
  desc "Opinionated CLI for AI agent-driven development with beads"
  homepage "https://github.com/nicholasspencer/factoryskills"
  version "0.6.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://api.github.com/repos/nicholasspencer/factoryskills/releases/assets/417991387",
          headers: [
            "Authorization: Bearer #{ENV["HOMEBREW_GITHUB_API_TOKEN"]}",
            "Accept: application/octet-stream",
          ]
      sha256 "4a08ed6038ff88af5d5cea94bc01c2c46d9e6ee8007d9d7dafa3ccfe2c30e16f"
    else
      url "https://api.github.com/repos/nicholasspencer/factoryskills/releases/assets/417991388",
          headers: [
            "Authorization: Bearer #{ENV["HOMEBREW_GITHUB_API_TOKEN"]}",
            "Accept: application/octet-stream",
          ]
      sha256 "f576709f7ccc2867d2dadf258731299cb973703ae48243bb25053a6c5631831c"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://api.github.com/repos/nicholasspencer/factoryskills/releases/assets/417991386",
          headers: [
            "Authorization: Bearer #{ENV["HOMEBREW_GITHUB_API_TOKEN"]}",
            "Accept: application/octet-stream",
          ]
      sha256 "a8cf206f2c017b850d68be652858f073feeb42015392ae51970d8b31d4ef6f00"
    else
      url "https://api.github.com/repos/nicholasspencer/factoryskills/releases/assets/417991385",
          headers: [
            "Authorization: Bearer #{ENV["HOMEBREW_GITHUB_API_TOKEN"]}",
            "Accept: application/octet-stream",
          ]
      sha256 "000d3634a9164aa0f6e31b7727724bf84c2c08069e52401cc2d2555036d97949"
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
