require "download_strategy"

# Custom download strategy for private GitHub release assets.
#
# Why this exists: Homebrew 4.x+ scrubs HOMEBREW_GITHUB_API_TOKEN from the
# formula-evaluation context for security (formulas could leak tokens to
# attacker-controlled URLs). The previous pattern of interpolating
# `ENV["HOMEBREW_GITHUB_API_TOKEN"]` into a Bearer header silently produced
# an empty token, every install/upgrade 401'd.
#
# Instead, this strategy reads the token from `gh auth token` at download
# time, after Homebrew's env-scrub. `depends_on "gh"` (below) guarantees
# `gh` is available; the user must have run `gh auth login` already.
class GitHubPrivateReleaseAssetDownloadStrategy < CurlDownloadStrategy
  def _fetch(url:, resolved_url:, timeout:)
    # Homebrew sanitizes PATH for formula subprocesses, so reference gh via
    # its absolute install path. `depends_on "gh"` guarantees it's installed.
    gh_bin = "#{HOMEBREW_PREFIX}/bin/gh"
    token = `#{gh_bin} auth token 2>/dev/null`.strip
    if token.empty?
      raise CurlDownloadStrategyError,
            "Failed to read GitHub token via `#{gh_bin} auth token`. Run `gh auth login` first."
    end
    curl_download(
      url,
      "--header", "Authorization: Bearer #{token}",
      "--header", "Accept: application/octet-stream",
      to: temporary_path,
      timeout: timeout,
    )
  end
end

class Factoryskills < Formula
  desc "Opinionated CLI for AI agent-driven development with beads"
  homepage "https://github.com/nicholasspencer/factoryskills"
  version "0.11.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://api.github.com/repos/nicholasspencer/factoryskills/releases/assets/427506409",
          using: GitHubPrivateReleaseAssetDownloadStrategy
      sha256 "7a2b9882ac099d88ce02e60ce74b2ca90d2b72b698e61d51044c63fd9166f243"
    else
      url "https://api.github.com/repos/nicholasspencer/factoryskills/releases/assets/427506408",
          using: GitHubPrivateReleaseAssetDownloadStrategy
      sha256 "26ed68458a8cc9521799c807a3420ac0d63372ca432a8156ac5a9c0510e849ac"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://api.github.com/repos/nicholasspencer/factoryskills/releases/assets/427506410",
          using: GitHubPrivateReleaseAssetDownloadStrategy
      sha256 "5cbaf29c9d7a86d32f43233cdd706852085bf61e2bdee1a849964d0de4de4067"
    else
      url "https://api.github.com/repos/nicholasspencer/factoryskills/releases/assets/427506407",
          using: GitHubPrivateReleaseAssetDownloadStrategy
      sha256 "6dd822e031206ae68c1a0edf8f0b3e5eb70d535aebbe57a869d347d394b81822"
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
