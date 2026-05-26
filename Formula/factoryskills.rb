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
  version "0.12.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://api.github.com/repos/nicholasspencer/factoryskills/releases/assets/429868750",
          using: GitHubPrivateReleaseAssetDownloadStrategy
      sha256 "8ecf2ae5fc100188d4df9c6022644af5b3c2ece9ec9eacfb49820bc77bc6af9e"
    else
      url "https://api.github.com/repos/nicholasspencer/factoryskills/releases/assets/429868748",
          using: GitHubPrivateReleaseAssetDownloadStrategy
      sha256 "9300c37073f56f1684270792c24800e2ee986f9816e1f87486334e776d8b9c6b"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://api.github.com/repos/nicholasspencer/factoryskills/releases/assets/429868749",
          using: GitHubPrivateReleaseAssetDownloadStrategy
      sha256 "d552036422e10fdde9bd2f38ac98e58184bbdd5926e85d7ae875c239cb5d3540"
    else
      url "https://api.github.com/repos/nicholasspencer/factoryskills/releases/assets/429868747",
          using: GitHubPrivateReleaseAssetDownloadStrategy
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
