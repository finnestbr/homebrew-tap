class Finnest < Formula
  desc "Finnest Customer CLI"
  homepage "https://finnest.com.br"
  version "0.10.3"
  license "UNLICENSED"

  resource "finnest-runtime" do
    on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.10.3/finnest-runtime-darwin-arm64.tar.gz"
      sha256 "17defe281c3c3d6cb22f18f52dbbea468cb88c4ab9a61eb0883d80279d6905f3"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.10.3/finnest-runtime-darwin-x64.tar.gz"
      sha256 "161efe6c1ee64cd14cace560cb0e99d6b4923677c1e60c7e8b0fce6120cee728"
    end
    end
    on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.10.3/finnest-runtime-linux-arm64.tar.gz"
      sha256 "11c4b76792384acadfda0dc73b68ea35284fe1f7f72fc7623103ad7b4ca325e9"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.10.3/finnest-runtime-linux-amd64.tar.gz"
      sha256 "956b795b6dae06393a6454aef9356049e7061111e6cbb13eaca502a928ae7d9a"
    end
    end
  end

  on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.10.3/finnest-darwin-arm64.gz"
      sha256 "4963d22bd89a010f789ea59104d22c12d08ee2ea034a546944428ee9e833e68c"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.10.3/finnest-darwin-x64.gz"
      sha256 "2da0175aa04eec2a96e52b81f6753b25cec5c58b914a5ed96a8561d0d2ef42f3"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.10.3/finnest-linux-arm64.gz"
      sha256 "7f55f7bccd96a2b91f5dced891408e6c31bbc90ac01a69a9c15e9312fcbc6d2b"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.10.3/finnest-linux-amd64.gz"
      sha256 "01603c676d98b418914f14c2bea195a3b1c69f87e3d9df594ca25a7d67f903d7"
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
