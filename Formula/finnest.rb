class Finnest < Formula
  desc "Finnest Customer CLI"
  homepage "https://finnest.com.br"
  version "0.19.7"
  license "UNLICENSED"

  resource "finnest-runtime" do
    on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.7/finnest-runtime-darwin-arm64.tar.gz"
      sha256 "72817191aa8689aff3fcf7a03edfe50cb7535162bafa9de32dcbe965c1111db3"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.7/finnest-runtime-darwin-x64.tar.gz"
      sha256 "35b58363497a021ed34da3edead270c45e3a95ec9a2a62f9716be71d2986174d"
    end
    end
    on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.7/finnest-runtime-linux-arm64.tar.gz"
      sha256 "418b16c9492163d99dc93601c94cac947790834aeceb29f914d1abd7e8b017f4"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.7/finnest-runtime-linux-amd64.tar.gz"
      sha256 "39d403091beaf1ab0a9720aa4cb1c0fbff04dec9e72ad69f3469170f785771dd"
    end
    end
  end

  on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.7/finnest-darwin-arm64.gz"
      sha256 "19bd1f93bd7e6d57b92af02899c79e6bde32f1894d4a56c95a90c2253c7a6f5b"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.7/finnest-darwin-x64.gz"
      sha256 "fd89e3db2448969e2f2886c87322fc13f9467a73c737ab9c393c820ed192310c"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.7/finnest-linux-arm64.gz"
      sha256 "2100c45463ff291fbf5e01237f2f57d47f451008af17d3492c8dee7f5e006be8"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.7/finnest-linux-amd64.gz"
      sha256 "531a61896281d8f39d4c3731547b1df18d916f4b2974466d78ec628e835df919"
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
