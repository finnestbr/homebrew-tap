class Finnest < Formula
  desc "Finnest Customer CLI"
  homepage "https://finnest.com.br"
  version "0.17.0"
  license "UNLICENSED"

  resource "finnest-runtime" do
    on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.17.0/finnest-runtime-darwin-arm64.tar.gz"
      sha256 "9755c83028e2fa3d5c6b1b1df255b56c4762dd7e6ebf656559b3af3a3d2a3a35"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.17.0/finnest-runtime-darwin-x64.tar.gz"
      sha256 "6bc630e3b7f1dd7e9db3e6a0631c11235663bfaaf056f3dc01e7b1121a59b160"
    end
    end
    on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.17.0/finnest-runtime-linux-arm64.tar.gz"
      sha256 "3cb174ef107fa692b7083861e603d2e18f590e950c74f93038d2f515b3041cd8"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.17.0/finnest-runtime-linux-amd64.tar.gz"
      sha256 "4287865aae7198f91436bfecd5cd55e95d4b78cad82c508d6d38cde4a44abec3"
    end
    end
  end

  on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.17.0/finnest-darwin-arm64.gz"
      sha256 "74604fed3ad7ee55ced2a633f65c08333a98e2861ec9cb60234e7356f32468cf"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.17.0/finnest-darwin-x64.gz"
      sha256 "abaa5eb4be36c8324a56b38e21dfbd42b4edc26014473e90f8cc5da25b13a745"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.17.0/finnest-linux-arm64.gz"
      sha256 "5e39f565fed43b638311e3d74f6cea91e5bd48db00a2efe89a7ee75fc187f7d9"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.17.0/finnest-linux-amd64.gz"
      sha256 "5e2f4bd246b0c53a40d947b1966fd120491395fcd6c1850e8ae7bc1a0c213243"
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
