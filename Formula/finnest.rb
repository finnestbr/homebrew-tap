class Finnest < Formula
  desc "Finnest Customer CLI"
  homepage "https://finnest.com.br"
  version "0.6.39"
  license "UNLICENSED"

  on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.6.39/finnest-darwin-arm64"
      sha256 "6bde4b577e2569a84c9f169eb5a1b1726c931ebe358a5fe6bed8a5836499824a"
      resource "finnest-runtime" do
        url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.6.39/finnest-runtime-darwin-arm64.tar.gz"
        sha256 "585b8b4cd464a4cd1c4bbb47268cc502862c03f224b6abfcd4ea82cfbedafd0c"
      end
    end
  end
  on_macos do
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.6.39/finnest-darwin-x64"
      sha256 "e59334d642359908c2002278f0c434465bdff25ef9142317713335691ce53743"
      resource "finnest-runtime" do
        url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.6.39/finnest-runtime-darwin-x64.tar.gz"
        sha256 "ef7cf61ec51a5529e0f55aab4c2d631a49109652d8013f3bd227ea45fc894e7a"
      end
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.6.39/finnest-linux-arm64"
      sha256 "886aa3e67bda694175dc5358f3be6cdaac848f85445bd45005220e76229bbad8"
      resource "finnest-runtime" do
        url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.6.39/finnest-runtime-linux-arm64.tar.gz"
        sha256 "759be69545ceb21ff66d37c537d8d759411804a92c216bbd9426c1284bc0efed"
      end
    end
  end
  on_linux do
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.6.39/finnest-linux-amd64"
      sha256 "971396b3dd5944993a6538da2ea9ae02df05f7a00504fe390aea866bfede77cd"
      resource "finnest-runtime" do
        url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.6.39/finnest-runtime-linux-amd64.tar.gz"
        sha256 "637fe1c935672cbef8ba8490f6fea0094736b7fa3e0e9a8ef09958603007ddaa"
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
