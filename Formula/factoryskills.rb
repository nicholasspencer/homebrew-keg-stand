class Factoryskills < Formula
  desc "Opinionated CLI for AI agent-driven development with beads"
  homepage "https://github.com/nicholasspencer/factoryskills"
  version "0.3.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://api.github.com/repos/nicholasspencer/factoryskills/releases/assets/413918787",
          headers: [
            "Authorization: Bearer #{ENV["HOMEBREW_GITHUB_API_TOKEN"]}",
            "Accept: application/octet-stream",
          ]
      sha256 "9e4d61105ed141c7b71efec086a4f3bb43781c7e99099dbc5078ab93d47cea32"
    else
      url "https://api.github.com/repos/nicholasspencer/factoryskills/releases/assets/413918786",
          headers: [
            "Authorization: Bearer #{ENV["HOMEBREW_GITHUB_API_TOKEN"]}",
            "Accept: application/octet-stream",
          ]
      sha256 "b892112edebf412cb676f271e3e44c9cfe7c65cca7f9b9c92283550af270e805"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://api.github.com/repos/nicholasspencer/factoryskills/releases/assets/413918784",
          headers: [
            "Authorization: Bearer #{ENV["HOMEBREW_GITHUB_API_TOKEN"]}",
            "Accept: application/octet-stream",
          ]
      sha256 "2b728dc84b78149cc9b6888e67e1a0893b1b36a069dd8b6110581b5c21b540a3"
    else
      url "https://api.github.com/repos/nicholasspencer/factoryskills/releases/assets/413918783",
          headers: [
            "Authorization: Bearer #{ENV["HOMEBREW_GITHUB_API_TOKEN"]}",
            "Accept: application/octet-stream",
          ]
      sha256 "13ed9cc19ad79fdad3fcee2051f0c8874c383773f548ffeafe19e8234c9e5eb5"
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
    assert_match "fs #{version}", shell_output("#{bin}/fs version")
  end
end
