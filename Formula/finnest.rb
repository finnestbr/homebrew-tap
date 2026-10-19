class Finnest < Formula
  desc "Finnest Customer CLI"
  homepage "https://finnest.com.br"
  version "0.22.7"
  license "UNLICENSED"

  resource "finnest-runtime" do
    on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.22.7/finnest-runtime-darwin-arm64.tar.gz"
      sha256 "f4869ba1a5ad28b7d1240a457f0a7cb2cfddddbcb76988f71a7758982aaa77e1"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.22.7/finnest-runtime-darwin-x64.tar.gz"
      sha256 "878f4595fc4352aaf235d182498324339311347e9da5a577bc386f87267e0044"
    end
    end
    on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.22.7/finnest-runtime-linux-arm64.tar.gz"
      sha256 "13fbb5e247e0e5b325e5681847d0303ffc1c814835e85011907fdd263914c084"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.22.7/finnest-runtime-linux-amd64.tar.gz"
      sha256 "f6bb491002f2a00d9d2f8039f54106c13efe35c5b0087bbff9cab8cbc1eee9e8"
    end
    end
  end

  on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.22.7/finnest-darwin-arm64.gz"
      sha256 "7a9e2c250ed3df863bd0c02dffdb4374156b1ec66a948c977710040772caaf42"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.22.7/finnest-darwin-x64.gz"
      sha256 "108e57ce2a09588253f06483edc82f78380b6415fc1187141892b8c70068ecdd"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.22.7/finnest-linux-arm64.gz"
      sha256 "8955364faa90d32ce0cba88683c25649fcc624fb8a20c2fd68585a2f76adaf31"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.22.7/finnest-linux-amd64.gz"
      sha256 "5ce3bcc1dc052a9d2306a76c2b811ba666a4990ab9c8eed73225ff4853136d4d"
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
