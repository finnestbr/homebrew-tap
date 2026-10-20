class Finnest < Formula
  desc "Finnest Customer CLI"
  homepage "https://finnest.com.br"
  version "0.25.5"
  license "UNLICENSED"

  resource "finnest-runtime" do
    on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.25.5/finnest-runtime-darwin-arm64.tar.gz"
      sha256 "a687e6b1b09f16243f398756da7120949ca2bcd812571f87e775ca55783c6b66"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.25.5/finnest-runtime-darwin-x64.tar.gz"
      sha256 "546061f71814950569264628258a10e36910769b5189c11c09f22745fcb065ef"
    end
    end
    on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.25.5/finnest-runtime-linux-arm64.tar.gz"
      sha256 "64c1be7b91bbc5f74fcfcb9bdc64709f81f16f83d325615d1d77add134d17f8b"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.25.5/finnest-runtime-linux-amd64.tar.gz"
      sha256 "b68c38cc44464781a962992643fc4e6bb9924988b16a3c44b0058870593ffa04"
    end
    end
  end

  on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.25.5/finnest-darwin-arm64.gz"
      sha256 "4bb9621e7ef1d47ea577b066b92ec41e4c57a42dc5e1a8bd7083bd22cd7bce61"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.25.5/finnest-darwin-x64.gz"
      sha256 "82f87aea9e25c28d40099f6753dcefd5e913e2fdca207ac16344d186208f9b78"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.25.5/finnest-linux-arm64.gz"
      sha256 "629f199ab0aa7d64428ae0b3ab5be22da022f697c5d2959ac66a1e90bbe7b0cc"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.25.5/finnest-linux-amd64.gz"
      sha256 "b376230255d548e03219390933213c25ef87ecb1d257bcb394c7fdb6506c6935"
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
