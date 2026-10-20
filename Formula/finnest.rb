class Finnest < Formula
  desc "Finnest Customer CLI"
  homepage "https://finnest.com.br"
  version "0.25.4"
  license "UNLICENSED"

  resource "finnest-runtime" do
    on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.25.4/finnest-runtime-darwin-arm64.tar.gz"
      sha256 "4598421cf5647377ca967ae82621325d839c23d356025608e6cbb911b0cc354e"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.25.4/finnest-runtime-darwin-x64.tar.gz"
      sha256 "d148dc693971bcab792fccf4fc2f6beb65446145400c7d1ba44faa3355b345ef"
    end
    end
    on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.25.4/finnest-runtime-linux-arm64.tar.gz"
      sha256 "fd139925a59fb0f3febe9c27a7730da8d0c6f2664f2b01cfda39a39464e511bb"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.25.4/finnest-runtime-linux-amd64.tar.gz"
      sha256 "e052f57f0de8a346b95d162b5ee1c897eaad2eda208232e3651a5dc4394b2319"
    end
    end
  end

  on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.25.4/finnest-darwin-arm64.gz"
      sha256 "eb941f003a068c23ca74eebd4291bfd36c656dce0a6d268871d92f73654356f2"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.25.4/finnest-darwin-x64.gz"
      sha256 "4ecdee11003f31da09fe4894568ed7b0e70329ac3023ea5f804bbfa86ffd71d7"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.25.4/finnest-linux-arm64.gz"
      sha256 "d1539dd3267ad9fb272d565c85dbaee62a598f716db2a4181e20246b91477635"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.25.4/finnest-linux-amd64.gz"
      sha256 "905437f14d155ec718f40e56349b31e66d0faa68ac04a9b34a07e300bc96b062"
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
