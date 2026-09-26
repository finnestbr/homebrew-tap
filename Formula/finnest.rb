class Finnest < Formula
  desc "Finnest Customer CLI"
  homepage "https://finnest.com.br"
  version "0.8.39"
  license "UNLICENSED"

  resource "finnest-runtime" do
    on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.8.39/finnest-runtime-darwin-arm64.tar.gz"
      sha256 "880b6dd70832a74fd8badb09190b9cc9cc791bb792844a2d2c307f32f4955459"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.8.39/finnest-runtime-darwin-x64.tar.gz"
      sha256 "ba156dd8d5851d93f982b01a3ecc77d9a1ff34708e0ca3f7478819b85d7bd793"
    end
    end
    on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.8.39/finnest-runtime-linux-arm64.tar.gz"
      sha256 "ea8c2089cff3d310eeb1e71891f860dec725e9c741181170f1e9fd17c56c3020"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.8.39/finnest-runtime-linux-amd64.tar.gz"
      sha256 "eb1093021bb585d753de98926807f66e92d575fc129efe0dab63899104610fc9"
    end
    end
  end

  on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.8.39/finnest-darwin-arm64.gz"
      sha256 "78255c303699448450a5090958c0856d4b517e4d19a56442c7e2cc068cad6e78"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.8.39/finnest-darwin-x64.gz"
      sha256 "94a9618cae255e88975d90044f30d1e2061254dfaab68a50813131f7e3edb308"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.8.39/finnest-linux-arm64.gz"
      sha256 "ac03538bfec16ece2769f508d613ee1d7818cf2a7b2c1379bf6ce601778f748b"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.8.39/finnest-linux-amd64.gz"
      sha256 "ba231953fd1e36bb4ecf07331baad0ac7780e9a9da656bd942f82cf057b40e3c"
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
