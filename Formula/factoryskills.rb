class Factoryskills < Formula
  desc "Opinionated CLI for AI agent-driven development with beads"
  homepage "https://github.com/nicholasspencer/factoryskills"
  version "0.2.3"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://api.github.com/repos/nicholasspencer/factoryskills/releases/assets/405648571",
          headers: [
            "Authorization: Bearer #{ENV["HOMEBREW_GITHUB_API_TOKEN"]}",
            "Accept: application/octet-stream",
          ]
      sha256 "90cc5b8e09de4dbb73ea1b727da3d4a785f040dcacad0909bc88a0efa6d36968"
    else
      url "https://api.github.com/repos/nicholasspencer/factoryskills/releases/assets/405648572",
          headers: [
            "Authorization: Bearer #{ENV["HOMEBREW_GITHUB_API_TOKEN"]}",
            "Accept: application/octet-stream",
          ]
      sha256 "71cd9a259d2606c8be3866cc0189ee7be828d04dc18fe0b0cf435093bf8588fc"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://api.github.com/repos/nicholasspencer/factoryskills/releases/assets/405648570",
          headers: [
            "Authorization: Bearer #{ENV["HOMEBREW_GITHUB_API_TOKEN"]}",
            "Accept: application/octet-stream",
          ]
      sha256 "46aff1a80715e153d696d613e7aca9cc52bc04ba0927b3e7ba198b07dcff564e"
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
