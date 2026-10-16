class Finnest < Formula
  desc "Finnest Customer CLI"
  homepage "https://finnest.com.br"
  version "0.19.35"
  license "UNLICENSED"

  resource "finnest-runtime" do
    on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.35/finnest-runtime-darwin-arm64.tar.gz"
      sha256 "a913334a4fc8a2927c384320d1455abee87676783085a9b6b37320d864a8c94b"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.35/finnest-runtime-darwin-x64.tar.gz"
      sha256 "2a866068a9fb85a527b32cb8d70b7c9ed0e8fca8e711c37bf3cf9f82505255b1"
    end
    end
    on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.35/finnest-runtime-linux-arm64.tar.gz"
      sha256 "51d23477a178403dc43ed909717d8d156d3759611becd7cdd018652a5b279a4e"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.35/finnest-runtime-linux-amd64.tar.gz"
      sha256 "cce8d1194a3f511906c0646ab6ddc7521c486dc9f81b7cd406014dea82de50ef"
    end
    end
  end

  on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.35/finnest-darwin-arm64.gz"
      sha256 "7e4c9e01255bc03996fcca204acd3a1f36ef7066a987d1326b947c031030985f"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.35/finnest-darwin-x64.gz"
      sha256 "45b7973c5d08ada554837ccf2eb1ea6423d050cf2fd429adeee648a07492769f"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.35/finnest-linux-arm64.gz"
      sha256 "5fad6c0ed4fa7752e89f44c391e75d8c0a90b1d99511beb7b4b7406b19bdd859"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.35/finnest-linux-amd64.gz"
      sha256 "1fd8b521ce89ff18889152fb521addef6bd9fe987de234f7c601b70c37ab55cc"
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
