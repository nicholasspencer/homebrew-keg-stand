class Factoryskills < Formula
  desc "Opinionated CLI for AI agent-driven development with beads"
  homepage "https://github.com/nicholasspencer/factoryskills"
  version "0.2.8"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://api.github.com/repos/nicholasspencer/factoryskills/releases/assets/410909535",
          headers: [
            "Authorization: Bearer #{ENV["HOMEBREW_GITHUB_API_TOKEN"]}",
            "Accept: application/octet-stream",
          ]
      sha256 "2a7144c8f8f28096807c7e14922f5191069807570463b3d9c57ad7f649837938"
    else
      url "https://api.github.com/repos/nicholasspencer/factoryskills/releases/assets/410909533",
          headers: [
            "Authorization: Bearer #{ENV["HOMEBREW_GITHUB_API_TOKEN"]}",
            "Accept: application/octet-stream",
          ]
      sha256 "ff1e0fd39e566aff50e338f2d3979a4241c149103f7cd885fa8b035fab6265e4"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://api.github.com/repos/nicholasspencer/factoryskills/releases/assets/410909532",
          headers: [
            "Authorization: Bearer #{ENV["HOMEBREW_GITHUB_API_TOKEN"]}",
            "Accept: application/octet-stream",
          ]
      sha256 "22bcdae73f5e497b987c922c62e740e016c65c5ca07a9911046ff9b3e4210d97"
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
