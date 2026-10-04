class Finnest < Formula
  desc "Finnest Customer CLI"
  homepage "https://finnest.com.br"
  version "0.14.2"
  license "UNLICENSED"

  resource "finnest-runtime" do
    on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.14.2/finnest-runtime-darwin-arm64.tar.gz"
      sha256 "a9354374d38f1ce88b587efa247df8bcb695377babc18ee3540713a55f008804"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.14.2/finnest-runtime-darwin-x64.tar.gz"
      sha256 "8873c189eccbcaf353c80b18b33a03a8e7e52704ff04184c8c9bb4eb4ae86f40"
    end
    end
    on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.14.2/finnest-runtime-linux-arm64.tar.gz"
      sha256 "daf8c14d0a54a40a7d13c2015774ec6b3638faeeed84048963f2c17c4fedf82d"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.14.2/finnest-runtime-linux-amd64.tar.gz"
      sha256 "60831ff4efcaf6835bb5b30fbd64004090406d80b763cfc569796293c30d72ad"
    end
    end
  end

  on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.14.2/finnest-darwin-arm64.gz"
      sha256 "2377afa84307517d92ff5fbe3033082216fd023becbf52d6d1dabd92778d71de"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.14.2/finnest-darwin-x64.gz"
      sha256 "af405e9725e1b4117790f3cb065dd004bcb416fef1884cbfb04fe1ca68ea340c"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.14.2/finnest-linux-arm64.gz"
      sha256 "521ef0eb8f2bf54e81ba1d8849cd4bb937864c7bed4e2691e3217348acec807d"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.14.2/finnest-linux-amd64.gz"
      sha256 "3957d364248725208c4b9f90fb7ddc2a57c77ba23c463eaf88ed4b8520b0cc57"
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
