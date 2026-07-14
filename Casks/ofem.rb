# frozen_string_literal: true

# Homebrew cask for OFEM — OneLake Explorer for macOS.
#
# This file is a template. The release workflow renders it by substituting:
#   2026.07.2   -> CalVer string, e.g. 2026.05.1
#   2e95f5481190ba1d8a39e92dfb76831d9a1ad44134beb518314d917bd9c6231a -> SHA-256 of the signed and notarized DMG
#
# The rendered file is committed to sdebruyn/homebrew-ofem as Casks/ofem.rb
# by the `Update Homebrew cask` step in .github/workflows/release.yml.
cask "ofem" do
  version "2026.07.2"
  sha256 "2e95f5481190ba1d8a39e92dfb76831d9a1ad44134beb518314d917bd9c6231a"

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
    # Host app and FPE are both sandboxed, so their preferences live
    # inside their own containers, not ~/Library/Preferences directly.
    "~/Library/Containers/dev.debruyn.ofem",
    "~/Library/Containers/dev.debruyn.ofem.fileprovider",
    "~/Library/Group Containers/6D79CUWZ4J.group.dev.debruyn.ofem",
  ]
end
