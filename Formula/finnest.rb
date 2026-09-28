class Finnest < Formula
  desc "Finnest Customer CLI"
  homepage "https://finnest.com.br"
  version "0.8.44"
  license "UNLICENSED"

  resource "finnest-runtime" do
    on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.8.44/finnest-runtime-darwin-arm64.tar.gz"
      sha256 "301be74207108f654dc937532a74e1e714f0721c551c9e77e28a866309887dec"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.8.44/finnest-runtime-darwin-x64.tar.gz"
      sha256 "bb0ccda7d5209e510ce8e99b44affb8cd09328bff1a9db6d3f032904aa4daecf"
    end
    end
    on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.8.44/finnest-runtime-linux-arm64.tar.gz"
      sha256 "083d90041979fe97a22174e7c57a47b8f77ae5709cffbeb6521afb02958f31a7"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.8.44/finnest-runtime-linux-amd64.tar.gz"
      sha256 "ee25d3a2e3f0154a2bb0f5a2eed8e683af6db96465a89646f14544c5b0b538d5"
    end
    end
  end

  on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.8.44/finnest-darwin-arm64.gz"
      sha256 "eeea1fcdfc0ad1048aa76a18d6567e62c03858efabadb5bed19c1303ee3d37a9"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.8.44/finnest-darwin-x64.gz"
      sha256 "4d69b6d8478ea47a6363917de98696423da79713fdb47389669f3a623eade172"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.8.44/finnest-linux-arm64.gz"
      sha256 "72e6dd9a0ebedf3f04360e724b13bdfc128ca610a7155db989713d545ff2e87d"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.8.44/finnest-linux-amd64.gz"
      sha256 "705405d36ed9103a5860b9327ed129405387e1b6ef22c3d9a9339fe7418a076e"
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
