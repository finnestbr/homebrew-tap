class Finnest < Formula
  desc "Finnest Customer CLI"
  homepage "https://finnest.com.br"
  version "0.27.27"
  license "UNLICENSED"

  resource "finnest-runtime" do
    on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.27.27/finnest-runtime-darwin-arm64.tar.gz"
      sha256 "a45c761f07be518cbe977d3d286a2bde13defba7f44fe56b238ccc92f9f725f7"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.27.27/finnest-runtime-darwin-x64.tar.gz"
      sha256 "55b903c2660dda05349654febfaa53467b23e4e3c8007c1e9a4568dd42bede63"
    end
    end
    on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.27.27/finnest-runtime-linux-arm64.tar.gz"
      sha256 "6d453a9fda854a9a75f41fb562b938cd2e34a905226cd07b389796ce85218726"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.27.27/finnest-runtime-linux-amd64.tar.gz"
      sha256 "f70bcd1fa853d7a07dcc457e537e693525f35d8b52fd27bc44c3776e1103f52f"
    end
    end
  end

  on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.27.27/finnest-darwin-arm64.gz"
      sha256 "784d30d1f6ae0f8f6f974e591c2a58a2b1187ac7855c18cbede76f78e0e3e14a"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.27.27/finnest-darwin-x64.gz"
      sha256 "05443e6b93ba692bcd7e1b4e5e8a1f878a6cd455712ee35f455e7de4cdb3a39e"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.27.27/finnest-linux-arm64.gz"
      sha256 "07bd5f29cb255b26aa705f410a5f24d6229c7e80e29bc887c5a3268fdf00e323"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.27.27/finnest-linux-amd64.gz"
      sha256 "67442b3956439d2ab6c7db065384b626743ec72f3da088291dbc85d39c73af4d"
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
