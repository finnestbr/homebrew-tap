class Finnest < Formula
  desc "Finnest Customer CLI"
  homepage "https://finnest.com.br"
  version "0.22.8"
  license "UNLICENSED"

  resource "finnest-runtime" do
    on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.22.8/finnest-runtime-darwin-arm64.tar.gz"
      sha256 "d3ea5b4fb965ab7952fe2aa30f43c2fb53be88e24b3062768f9bde6040170dc7"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.22.8/finnest-runtime-darwin-x64.tar.gz"
      sha256 "db2ccd185c7921514b3c16a7c1b0b9df5d0e179887911294dc3d1872aca0ce72"
    end
    end
    on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.22.8/finnest-runtime-linux-arm64.tar.gz"
      sha256 "5d0f8136bbfaef482d88e836a94a5ae21d0842936074174b0ee9dd1d6907c4d4"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.22.8/finnest-runtime-linux-amd64.tar.gz"
      sha256 "6e6c4476718e77089882585f2e8b37d24ce81d5e87cc18c2724bfea43445c542"
    end
    end
  end

  on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.22.8/finnest-darwin-arm64.gz"
      sha256 "1f974463941938f3ec9b9c2b89972fc2cb6b90e9d7399334713fe3352ee31320"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.22.8/finnest-darwin-x64.gz"
      sha256 "0dbac3250cc03c0d8b17fc46a1665a3ad1e33e842844f3490acfd86876cb7625"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.22.8/finnest-linux-arm64.gz"
      sha256 "a8d4d3fea6069a4d9a8a65b3ad1304237b8580aa3c148e5c629e63aaecfc96c3"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.22.8/finnest-linux-amd64.gz"
      sha256 "edea1653bd5c0b8460a9a4da210ce057545e51219a2053915c04dbefd9810b3a"
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
