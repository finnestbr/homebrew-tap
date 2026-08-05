class Finnest < Formula
  desc "Finnest Customer CLI"
  homepage "https://finnest.com.br"
  version "0.6.28"
  license "UNLICENSED"

  on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.6.28/finnest-darwin-arm64"
      sha256 "67cd484bf904dc08ff18c9b0ae5d48149031cd7e3057d975f4d6b21f4613a945"
      resource "finnest-runtime" do
        url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.6.28/finnest-runtime-darwin-arm64.tar.gz"
        sha256 "cde819f5b6bd3149a9090863d181b7d5a721bceb07c6d79eb2e9532776452d8e"
      end
    end
  end
  on_macos do
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.6.28/finnest-darwin-x64"
      sha256 "4548328c670a704e2d004e196c351db72afc8e5476fe552355b856b5e9985ec1"
      resource "finnest-runtime" do
        url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.6.28/finnest-runtime-darwin-x64.tar.gz"
        sha256 "708fd3a12e827d95588150601468d0a2365209e0637810fd3b19e9d56151f073"
      end
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.6.28/finnest-linux-arm64"
      sha256 "13fa2c3ca6c448f7bb47e340a2812a93bd520fe47f5c774e1631243ad8ff462a"
      resource "finnest-runtime" do
        url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.6.28/finnest-runtime-linux-arm64.tar.gz"
        sha256 "b08734735beae2f680e9066baf45c601e7a3206cab48c9020728eaeff5fe2829"
      end
    end
  end
  on_linux do
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.6.28/finnest-linux-amd64"
      sha256 "2844873c5030cdb946558ef7781f61b0167104e0797ad04e510c460bacd9e8de"
      resource "finnest-runtime" do
        url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.6.28/finnest-runtime-linux-amd64.tar.gz"
        sha256 "5b89b1ee72eababaea48c49b2a0f450bb3ee5c338151c789d617e29d29a92334"
      end
    end
  end

  def install
    asset = Dir["finnest-*"].first
    chmod 0755, asset
    bin.install asset => "finnest"
    resource("finnest-runtime").stage do
      prefix.install "finnest-runtime"
    end
  end

  test do
    assert_match "Usage: finnest", shell_output("#{bin}/finnest 2>&1", 0)
  end
end
