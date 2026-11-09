class Finnest < Formula
  desc "Finnest Customer CLI"
  homepage "https://finnest.com.br"
  version "0.33.1"
  license "UNLICENSED"

  resource "finnest-runtime" do
    on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.33.1/finnest-runtime-darwin-arm64.tar.gz"
      sha256 "4eae9f4a980f1a85bfd084382c6484ac39e37bf7473b962d8c005a98b75c2545"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.33.1/finnest-runtime-darwin-x64.tar.gz"
      sha256 "cdd6384f471eca999b62e3e0612cd01225ea3180a33d6b955e72ae1f6d2640c2"
    end
    end
    on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.33.1/finnest-runtime-linux-arm64.tar.gz"
      sha256 "0c1f4e2fd0eaa14fa5f5e43a870b11ec529fdd798f4b6f7b4e15abd4177b94db"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.33.1/finnest-runtime-linux-amd64.tar.gz"
      sha256 "deb28d5bbbde306ef7eae93a8b8338f23926b31393a9f8ad58a1dd0107be7f76"
    end
    end
  end

  on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.33.1/finnest-darwin-arm64.gz"
      sha256 "1b5c1b08ba849605f2e43f293f5fa31744f9ca17fd83e84b9004f1f03c803df8"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.33.1/finnest-darwin-x64.gz"
      sha256 "57c91f6b6f67ecbffcf095f7b4742b3af7e9b4498b9deda14af47a1639c892fe"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.33.1/finnest-linux-arm64.gz"
      sha256 "0be4f540af72338f71537e301c4e64e52f00845b0fae4605d222355211142f7e"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.33.1/finnest-linux-amd64.gz"
      sha256 "64f092f583f33f4aa4ea89e4b92206eca039a76a09ae49e807965ddf7aabd5d6"
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
