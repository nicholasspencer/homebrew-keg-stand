class Factoryskills < Formula
  desc "Opinionated CLI for AI agent-driven development with beads"
  homepage "https://github.com/nicholasspencer/factoryskills"
  version "0.2.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://api.github.com/repos/nicholasspencer/factoryskills/releases/assets/402167015",
          headers: [
            "Authorization: Bearer #{ENV["HOMEBREW_GITHUB_API_TOKEN"]}",
            "Accept: application/octet-stream",
          ]
      sha256 "2160f3ba0e00c4105ee21fd107eabbb4b1fa72eb10df15f9a9247422484ea75b"
    else
      url "https://api.github.com/repos/nicholasspencer/factoryskills/releases/assets/402167014",
          headers: [
            "Authorization: Bearer #{ENV["HOMEBREW_GITHUB_API_TOKEN"]}",
            "Accept: application/octet-stream",
          ]
      sha256 "78fda7e15f803ad7dfd55be13e141edc2ec86e1333ffa5fbd29f19d864a8ee6d"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://api.github.com/repos/nicholasspencer/factoryskills/releases/assets/402167013",
          headers: [
            "Authorization: Bearer #{ENV["HOMEBREW_GITHUB_API_TOKEN"]}",
            "Accept: application/octet-stream",
          ]
      sha256 "a4b05d85a1f007e0ef2f3de936a343081aea4b6da687f357b9d0977d066fb9fe"
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
