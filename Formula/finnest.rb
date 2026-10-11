class Finnest < Formula
  desc "Finnest Customer CLI"
  homepage "https://finnest.com.br"
  version "0.18.0"
  license "UNLICENSED"

  resource "finnest-runtime" do
    on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.18.0/finnest-runtime-darwin-arm64.tar.gz"
      sha256 "df163f45cb777442f60abe243e33c0134c69471682b0c184f0773b6ffeea97e0"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.18.0/finnest-runtime-darwin-x64.tar.gz"
      sha256 "c77985aba3f2c18c3f8bd350185fbbf8a1f4003307924f5938fc238b773ddff5"
    end
    end
    on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.18.0/finnest-runtime-linux-arm64.tar.gz"
      sha256 "a7785f92fa247bb3cb5942cdddb7e810da45566caf4539d8e80f4612910b4a16"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.18.0/finnest-runtime-linux-amd64.tar.gz"
      sha256 "bf89168f4e5f16969b7f7f4924c223f3a68ecd531ad907e01acd2b1dd86c97ba"
    end
    end
  end

  on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.18.0/finnest-darwin-arm64.gz"
      sha256 "e8181c43a55486288eb0324c91ae94e42cef1c62e4fa33a96b736d86e42500b7"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.18.0/finnest-darwin-x64.gz"
      sha256 "e8c31ddac0903ca2efcc7f293acc48be4861d519a34ce1da467b4245119b8310"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.18.0/finnest-linux-arm64.gz"
      sha256 "923f03efc5257c08f7b489a2a955c2b047ed4e1d7d4e7d49bb0add23e826cc70"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.18.0/finnest-linux-amd64.gz"
      sha256 "bbbf78a49c644348e31e785891a37bf0327cfdc2af3c9badefed70b05420af41"
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
