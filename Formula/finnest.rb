class Finnest < Formula
  desc "Finnest Customer CLI"
  homepage "https://finnest.com.br"
  version "0.19.28"
  license "UNLICENSED"

  resource "finnest-runtime" do
    on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.28/finnest-runtime-darwin-arm64.tar.gz"
      sha256 "73270af0fbaf4b498705aa4efce1ac5c40046370ab6355fe0c6851b9213e87bc"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.28/finnest-runtime-darwin-x64.tar.gz"
      sha256 "09ebff7f267eb57dcf474eff714753c214267ee610a640f9b134e258016d0eea"
    end
    end
    on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.28/finnest-runtime-linux-arm64.tar.gz"
      sha256 "7195cb89d1e3dfdd4b1a6559683b910e90667f2ca778781399843b402dddcb3f"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.28/finnest-runtime-linux-amd64.tar.gz"
      sha256 "53bbd0523a90d6837686d40dc3a203e74b81466fb85ec4d882cdceed87c7f640"
    end
    end
  end

  on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.28/finnest-darwin-arm64.gz"
      sha256 "995a770750abeabe15285c3239f08f4e8dab4e937587a3a795e24880d37d3633"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.28/finnest-darwin-x64.gz"
      sha256 "9b6537546c9b7b93ce11f03b932dfe17007122819431407fa3648bb189accda3"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.28/finnest-linux-arm64.gz"
      sha256 "f8336d3991f43bd0563eaf0a09db9a6d00dae3357f601ec2355c7c72aea1d535"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.28/finnest-linux-amd64.gz"
      sha256 "dd74ac80bc63e71f16144612000dab51581543fb4cf61229705687d11729a4e1"
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
