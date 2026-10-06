class Finnest < Formula
  desc "Finnest Customer CLI"
  homepage "https://finnest.com.br"
  version "0.15.8"
  license "UNLICENSED"

  resource "finnest-runtime" do
    on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.15.8/finnest-runtime-darwin-arm64.tar.gz"
      sha256 "26015fbc574696b5863aebac0e5919d7069f77d186fe144ee52927300c46b1e8"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.15.8/finnest-runtime-darwin-x64.tar.gz"
      sha256 "2eaa17046363f4abe6a57c8da2ad8f48fd586f0790d087cbadfa2584accce873"
    end
    end
    on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.15.8/finnest-runtime-linux-arm64.tar.gz"
      sha256 "21d849d7fff5823f39429dfd43258b948b364144905c798fe5b1163d67c30ad2"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.15.8/finnest-runtime-linux-amd64.tar.gz"
      sha256 "d848feb8ef23370e7a414e4e85edeec792dcfe3f60b2cd79fa43dac6e239175d"
    end
    end
  end

  on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.15.8/finnest-darwin-arm64.gz"
      sha256 "85eebf5a8e3726bd2bf5222cab7f080f839e73444b60253dcf5d012becdb7d90"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.15.8/finnest-darwin-x64.gz"
      sha256 "adf64389f384a74d462838b9078b89a71a1260a7b89440b20b8fefdbe9b5b746"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.15.8/finnest-linux-arm64.gz"
      sha256 "e0a0d0ea494312ff631309fc4efa50369030d431a1b6749e24deb3cb1d145194"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.15.8/finnest-linux-amd64.gz"
      sha256 "95e41be6d1519d8f405fa52770297ccf4c14e232a97490a4aad13a94270ba79b"
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
