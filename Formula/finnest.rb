class Finnest < Formula
  desc "Finnest Customer CLI"
  homepage "https://finnest.com.br"
  version "0.16.13"
  license "UNLICENSED"

  resource "finnest-runtime" do
    on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.16.13/finnest-runtime-darwin-arm64.tar.gz"
      sha256 "0012fe0b64ede440dcd5cd18311be38ad7b85ae89e14c93288331b49a9f43083"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.16.13/finnest-runtime-darwin-x64.tar.gz"
      sha256 "bee4bdf30c4cc689103a7317353a043e2394fb92fa3931cfca1207feb20d2fba"
    end
    end
    on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.16.13/finnest-runtime-linux-arm64.tar.gz"
      sha256 "a1abe21818ca4e2371d0c4b9b55ba89e616762fee6a09032a667a11fcc06c912"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.16.13/finnest-runtime-linux-amd64.tar.gz"
      sha256 "b9dbc3abe6988bc36e49f1cb5cd88071714c2c855807d649e37545844965f5aa"
    end
    end
  end

  on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.16.13/finnest-darwin-arm64.gz"
      sha256 "9ffed2f62fdc8ec7d84893b3c0a594ab6d1a8c2fa15a6f261f68c561cb0806af"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.16.13/finnest-darwin-x64.gz"
      sha256 "c42bccfe5f3d593e6f21878ac1d52a6d08b88c31e5cfcfc5601c1980118b29a0"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.16.13/finnest-linux-arm64.gz"
      sha256 "791c5031bc881bcc4cb75080a72498bbb1642ed4e906211642682871d47a8078"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.16.13/finnest-linux-amd64.gz"
      sha256 "07af9df912575ac0cf032e369a060bd61918a8283e103c4c34e51e1dd7b4022a"
    end
  end

  def install
    asset = Dir["finnest-*"].first
    chmod 0755, asset
    libexec.install asset => "finnest"
    resource("finnest-runtime").stage do
      (libexec/"finnest-runtime").install Dir["*"]
      (libexec/"finnest-runtime").install ".finnest-toolchain-identity"
    end
    bin.install_symlink libexec/"finnest"
  end

  test do
    output = shell_output("#{bin}/finnest version --json")
    assert_match(/"version":\s*"#{Regexp.escape(version.to_s)}"/, output)
    assert_match(/"runtimeBundle":\s*\{\s*"status":\s*"ok"/, output)
  end
end
