class Finnest < Formula
  desc "Finnest Customer CLI"
  homepage "https://finnest.com.br"
  version "0.22.4"
  license "UNLICENSED"

  resource "finnest-runtime" do
    on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.22.4/finnest-runtime-darwin-arm64.tar.gz"
      sha256 "8aef8a3bb596ae3954ae7ad76ea5adcccaea2afe94738c1ffcd5b224a993b758"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.22.4/finnest-runtime-darwin-x64.tar.gz"
      sha256 "ada9b49bf9726fcaff96ce29f521d21203b6369614f3103302a3c270b0be4a8b"
    end
    end
    on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.22.4/finnest-runtime-linux-arm64.tar.gz"
      sha256 "bc9ebc96b92a6736dd850faea2b9b519ae34f711d10a884a3545a9413c84ea09"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.22.4/finnest-runtime-linux-amd64.tar.gz"
      sha256 "4e9a2d9b6d4f8a8af46af9976a6ba36f90522cb17352a733bce4cac31f56e396"
    end
    end
  end

  on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.22.4/finnest-darwin-arm64.gz"
      sha256 "4cc646b8e40131d44d65cd767e69a165d499bca0e2d3b3d6b0396add41b3de7c"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.22.4/finnest-darwin-x64.gz"
      sha256 "285f4f18d474a5229574e0f0b672946fda08c7797ff0535876c3a8cec44ecd8f"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.22.4/finnest-linux-arm64.gz"
      sha256 "668c98cf0b38c492ec83df5f201b23e1de64afddeedafc882d01c959dc3c529f"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.22.4/finnest-linux-amd64.gz"
      sha256 "b352386818b3f2ff0f51040603be2001ef5e5aa3fa9a773278ab754e0e9e3d58"
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
