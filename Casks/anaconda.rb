cask "anaconda" do
  version "2020.07"
  sha256 "3980c2a57fde5de2ccfdf0d7973f95ac1a3fa63351642e6735c50fc3791ef0f1"

  url "https://repo.anaconda.com/archive/Anaconda3-#{version}-MacOSX-x86_64.sh"
  name "Continuum Analytics Anaconda"
  homepage "https://www.anaconda.com/"

  auto_updates true
  container type: :naked

  installer script: {
    executable: "Anaconda3-#{version}-MacOSX-x86_64.sh",
    args:       ["-f", "-b", "-p", "#{HOMEBREW_PREFIX}"],
    sudo:       true,
  }

  postflight do
    set_ownership "#{HOMEBREW_PREFIX}"
  end

  uninstall delete: [
    "#{HOMEBREW_PREFIX}/conda-meta",
    "#{HOMEBREW_PREFIX}/condabin",
    "#{HOMEBREW_PREFIX}/envs",
    "#{HOMEBREW_PREFIX}/LICENSE.txt",
    "#{HOMEBREW_PREFIX}/pkgs",
    "#{HOMEBREW_PREFIX}/shell",
    "#{HOMEBREW_PREFIX}/ssl,"
    "/Applications/Anaconda-Navigator.app",
  ]

  zap trash: [
    "~/Library/Application Support/com.apple.sharedfilelist/com.apple.LSSharedFileList.ApplicationRecentDocuments/com.continuum.io.sfl*",
    "~/Library/Application Support/com.apple.sharedfilelist/com.apple.LSSharedFileList.ApplicationRecentDocuments/com.continuum.python.sfl*",
    "~/.anaconda",
    "~/.conda",
    "~/.condarc",
  ]

  caveats do
    files_in_usr_local
  end
end
