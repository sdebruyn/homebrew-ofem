# frozen_string_literal: true

# Homebrew cask for OFEM — OneLake Explorer for macOS.
#
# This file is a template. The release workflow renders it by substituting:
#   2026.06.14   -> CalVer string, e.g. 2026.05.1
#   e95de8515a5f5e3e382c05dff2cc2f323ffaf9a21858bdd17b22532e37a4bb1d -> SHA-256 of the signed and notarized DMG
#
# The rendered file is committed to sdebruyn/homebrew-ofem as Casks/ofem.rb
# by the `Update Homebrew cask` step in .github/workflows/release.yml.
cask "ofem" do
  version "2026.06.14"
  sha256 "e95de8515a5f5e3e382c05dff2cc2f323ffaf9a21858bdd17b22532e37a4bb1d"

  url "https://github.com/sdebruyn/onelake-explorer-macos/releases/download/v#{version}/OneLake-#{version}.dmg",
      verified: "github.com/sdebruyn/onelake-explorer-macos/"
  name "OneLake Explorer for macOS"
  desc "Browse Microsoft Fabric OneLake from Finder"
  homepage "https://ofem.debruyn.dev/"

  livecheck do
    url :url
    strategy :github_releases
    regex(/^v(\d+\.\d+\.\d+)$/i)
  end

  # The app registers itself as a Login Item on first interactive launch.
  # Auto-opening on unattended `brew upgrade` is intrusive and unnecessary.
  auto_updates false
  depends_on macos: :sonoma
  depends_on arch: :arm64

  app "OneLake.app"

  uninstall quit: "dev.debruyn.ofem"

  zap trash: [
    # Each account materialises as its own File Provider domain.
    # Zapped only on explicit `brew uninstall --zap` to avoid data loss.
    "~/Library/CloudStorage/OneLake-*",
    "~/Library/Group Containers/6D79CUWZ4J.group.dev.debruyn.ofem",
    "~/Library/Preferences/dev.debruyn.ofem.plist",
  ]
end
