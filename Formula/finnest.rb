class Finnest < Formula
  desc "Finnest Customer CLI"
  homepage "https://finnest.com.br"
  version "0.19.24"
  license "UNLICENSED"

  resource "finnest-runtime" do
    on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.24/finnest-runtime-darwin-arm64.tar.gz"
      sha256 "927724765ad1d9273dada8c5e74e15eb04aa9d1f7966cba3294205157c272ab1"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.24/finnest-runtime-darwin-x64.tar.gz"
      sha256 "00bd9caadfaff1f5345188f075447e53b7356db3cd0f3ec86cda795b1a9931fe"
    end
    end
    on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.24/finnest-runtime-linux-arm64.tar.gz"
      sha256 "1ebc1da2025b7f8510684dd4672548dafd8f9b8c8b6281c1d031f52704d02f08"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.24/finnest-runtime-linux-amd64.tar.gz"
      sha256 "2f1d225a21813383555353a10ca28cb9014ba6727e416ce3e3130316e972896a"
    end
    end
  end

  on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.24/finnest-darwin-arm64.gz"
      sha256 "59dd6686a03ee7d40e5fe1368705685e5e870598c8a3eda6423a7dbab96106e3"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.24/finnest-darwin-x64.gz"
      sha256 "699cbe80989e04de2a9b4aed640fdba9624e0812a1b126c6ae63a49404e847bb"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.24/finnest-linux-arm64.gz"
      sha256 "db5408669298e51ffa28a108d3288bb41b314c880f7314b84e54c83304ccb102"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.24/finnest-linux-amd64.gz"
      sha256 "cbe0ca67eee5baae01afc734d0f01ccda69a553fda580f26b7f2376ec9f4afcf"
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
