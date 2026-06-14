# frozen_string_literal: true

# Homebrew cask for OFEM — OneLake Explorer for macOS.
#
# This file is a template. The release workflow renders it by substituting:
#   2026.06.12   -> CalVer string, e.g. 2026.05.1
#   1055af5e2b5b821b0ed224a76bfef91d1665b1fafbb8b77b895496cccdf448ac -> SHA-256 of the signed and notarized DMG
#
# The rendered file is committed to sdebruyn/homebrew-ofem as Casks/ofem.rb
# by the `Update Homebrew cask` step in .github/workflows/release.yml.
cask "ofem" do
  version "2026.06.12"
  sha256 "1055af5e2b5b821b0ed224a76bfef91d1665b1fafbb8b77b895496cccdf448ac"

  url "https://github.com/sdebruyn/onelake-explorer-macos/releases/download/v#{version}/OneLake-#{version}.dmg"
  name "OneLake Explorer for macOS"
  desc "Browse Microsoft Fabric OneLake from Finder"
  homepage "https://ofem.debruyn.dev"

  livecheck do
    # Skip until the first stable CalVer release tag is pushed. Once
    # v2026.MM.PATCH is live, replace with:
    #   url :url
    #   strategy :github_releases
    #   regex(/^v(\d+\.\d+\.\d+)$/i)
    skip "pre-release — no stable tag yet"
  end

  depends_on macos: :sonoma
  depends_on arch: :arm64

  app "OneLake.app"

  # Open the app post-install so the first launch happens immediately,
  # registering the login item and starting the File Provider Extension
  # without requiring the user to manually launch the app first.
  postflight do
    system_command "/usr/bin/open", args: ["-a", "OneLake"]
  end

  uninstall quit: "dev.debruyn.ofem"

  zap trash: [
    "~/Library/Group Containers/6D79CUWZ4J.group.dev.debruyn.ofem",
    "~/Library/Preferences/dev.debruyn.ofem.plist",
    # Each account materialises as its own File Provider domain.
    # Zapped only on explicit `brew uninstall --zap` to avoid data loss.
    "~/Library/CloudStorage/OneLake-*",
  ]
end
