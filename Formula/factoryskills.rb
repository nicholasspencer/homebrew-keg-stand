class Factoryskills < Formula
  desc "Opinionated CLI for AI agent-driven development with beads"
  homepage "https://github.com/nicholasspencer/factoryskills"
  version "0.3.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://api.github.com/repos/nicholasspencer/factoryskills/releases/assets/413920251",
          headers: [
            "Authorization: Bearer #{ENV["HOMEBREW_GITHUB_API_TOKEN"]}",
            "Accept: application/octet-stream",
          ]
      sha256 "013f20066341f9e5af2344ddc95b7769e6548f612cbfd3d21c5644e59c8e5106"
    else
      url "https://api.github.com/repos/nicholasspencer/factoryskills/releases/assets/413920253",
          headers: [
            "Authorization: Bearer #{ENV["HOMEBREW_GITHUB_API_TOKEN"]}",
            "Accept: application/octet-stream",
          ]
      sha256 "e211786f9cfcab247908b8315574031fe9483a0b057144b8eb0bb494f967d2a8"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://api.github.com/repos/nicholasspencer/factoryskills/releases/assets/413920252",
          headers: [
            "Authorization: Bearer #{ENV["HOMEBREW_GITHUB_API_TOKEN"]}",
            "Accept: application/octet-stream",
          ]
      sha256 "058722fc8667d81fe0114420f5f94520873b9543e7f4d0aa798ef2231e6efef0"
    else
      url "https://api.github.com/repos/nicholasspencer/factoryskills/releases/assets/413920254",
          headers: [
            "Authorization: Bearer #{ENV["HOMEBREW_GITHUB_API_TOKEN"]}",
            "Accept: application/octet-stream",
          ]
      sha256 "c57d4bfec1a57a150dc11d6d3d542d4067478cac4f83a6bdb9c08e7cb344d4da"
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
