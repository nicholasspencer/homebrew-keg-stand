class Factoryskills < Formula
  desc "Opinionated CLI for AI agent-driven development with beads"
  homepage "https://github.com/nicholasspencer/factoryskills"
  version "0.4.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://api.github.com/repos/nicholasspencer/factoryskills/releases/assets/415859613",
          headers: [
            "Authorization: Bearer #{ENV["HOMEBREW_GITHUB_API_TOKEN"]}",
            "Accept: application/octet-stream",
          ]
      sha256 "9744893af3354c598358f41be942552dbdd88bc85a1c6814cd9eddfbb185b6af"
    else
      url "https://api.github.com/repos/nicholasspencer/factoryskills/releases/assets/415859614",
          headers: [
            "Authorization: Bearer #{ENV["HOMEBREW_GITHUB_API_TOKEN"]}",
            "Accept: application/octet-stream",
          ]
      sha256 "605b5657798fe3ce3c2da52a2c4bf5f715459e2632094f9192796f88a6b83d49"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://api.github.com/repos/nicholasspencer/factoryskills/releases/assets/415859612",
          headers: [
            "Authorization: Bearer #{ENV["HOMEBREW_GITHUB_API_TOKEN"]}",
            "Accept: application/octet-stream",
          ]
      sha256 "17562a26270a244f75da0a10c500032600368395de633d8903b71818ff7eb221"
    else
      url "https://api.github.com/repos/nicholasspencer/factoryskills/releases/assets/415859615",
          headers: [
            "Authorization: Bearer #{ENV["HOMEBREW_GITHUB_API_TOKEN"]}",
            "Accept: application/octet-stream",
          ]
      sha256 "ccb3e7705fe8a966df4bd4503b978933eff8e4f3dc26954d698ebefb6013c2fe"
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
