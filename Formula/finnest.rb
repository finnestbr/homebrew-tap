class Finnest < Formula
  desc "Finnest Customer CLI"
  homepage "https://finnest.com.br"
  version "0.16.1"
  license "UNLICENSED"

  resource "finnest-runtime" do
    on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.16.1/finnest-runtime-darwin-arm64.tar.gz"
      sha256 "f8d8a6122ef025386879806d6e419454f50867150c87c77b78bfc0099ae74e9a"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.16.1/finnest-runtime-darwin-x64.tar.gz"
      sha256 "c5a4c1c1fb142ef9b1f25417c2c2624f28441c4226e7e8d4fe858e8ef7335b65"
    end
    end
    on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.16.1/finnest-runtime-linux-arm64.tar.gz"
      sha256 "e73637afbad1767db23911d78924aa63f6006a92113935099e86599818e5e404"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.16.1/finnest-runtime-linux-amd64.tar.gz"
      sha256 "641b37ba0e3ae417b9928b9f051f90b2dc12116aab38792318e0d3648978028e"
    end
    end
  end

  on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.16.1/finnest-darwin-arm64.gz"
      sha256 "245a9c1bc839c261d21484500bf0d22652802273b6e09232b317b4fb27fc815e"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.16.1/finnest-darwin-x64.gz"
      sha256 "814adcc557261fa7535bcf7ec7537914d9a04f152975f9db702c90749eb7008e"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.16.1/finnest-linux-arm64.gz"
      sha256 "41b0a4476ce8e1417ed64b6a94129fc51b0c1f81f6f14727bae0ab9d56b2ca20"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.16.1/finnest-linux-amd64.gz"
      sha256 "d8336948a6256d9ba628bc6659df15388220499ece3c6f6338a54fdadd936b40"
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
