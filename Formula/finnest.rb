class Finnest < Formula
  desc "Finnest Customer CLI"
  homepage "https://finnest.com.br"
  version "0.16.5"
  license "UNLICENSED"

  resource "finnest-runtime" do
    on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.16.5/finnest-runtime-darwin-arm64.tar.gz"
      sha256 "5f2ea686eadaf07b1e47f148f1f7850c5f56177587370edddf98fa5b1ddf0035"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.16.5/finnest-runtime-darwin-x64.tar.gz"
      sha256 "f77406b75775dd4ce82f831d9bcdf62b2643e59608cbe2df25fd072fa9d074a7"
    end
    end
    on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.16.5/finnest-runtime-linux-arm64.tar.gz"
      sha256 "1282ca620a27a6d8c08c511239550740f13a980d995ce14532c9c030c2c093d4"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.16.5/finnest-runtime-linux-amd64.tar.gz"
      sha256 "f1c277ce440c166f2c4f2d0399c87e907ca68a20752e8095104eddebeda83980"
    end
    end
  end

  on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.16.5/finnest-darwin-arm64.gz"
      sha256 "63bceeb27b1c747ae453782b72c6ccffedafe436fcf21a498011d215dde2ab94"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.16.5/finnest-darwin-x64.gz"
      sha256 "74376a9b24b03b10664dcf19533be2807a14b5d4d1f4af3c8d9fa75c4d95ab37"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.16.5/finnest-linux-arm64.gz"
      sha256 "174f72d32c623492752b40f5eefa94e150ff877738d8e06d3708073e71ef4bf2"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.16.5/finnest-linux-amd64.gz"
      sha256 "160a39137db4c8dc357bd4f1f038fe00d71fdd09f897c312d5bc5e61712e8935"
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
