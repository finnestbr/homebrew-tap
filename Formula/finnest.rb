class Finnest < Formula
  desc "Finnest Customer CLI"
  homepage "https://finnest.com.br"
  version "0.25.3"
  license "UNLICENSED"

  resource "finnest-runtime" do
    on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.25.3/finnest-runtime-darwin-arm64.tar.gz"
      sha256 "7c3823e69504936eacc4b0098fdedeef6887991054a7c87922bab17655dd4c3b"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.25.3/finnest-runtime-darwin-x64.tar.gz"
      sha256 "e313adc0dfd1bab5e43f6c1760ab97cb376b39e73127d72f3d6a9448301294da"
    end
    end
    on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.25.3/finnest-runtime-linux-arm64.tar.gz"
      sha256 "a79600c278b16d75b2dd1c5da3b8fb9c19c674eed3da62d8e817fa5d96ba19a1"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.25.3/finnest-runtime-linux-amd64.tar.gz"
      sha256 "4e2545b943ec08ea6547edb163e4b29fcc59b1537ee8a9ef6b334cbd5102cbdf"
    end
    end
  end

  on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.25.3/finnest-darwin-arm64.gz"
      sha256 "c210b4e33f51e0e5f5c8ba1fc567ba3fa81722a27ce122f548affef584c76ebe"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.25.3/finnest-darwin-x64.gz"
      sha256 "61b166ffaf8b82ec7257813428ebd4290b7aac732b642298bce80eaa5182480c"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.25.3/finnest-linux-arm64.gz"
      sha256 "b675aa3848e2af283a308f5528cea786dd5b2ce9670b236b4f61a8eef6ff2947"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.25.3/finnest-linux-amd64.gz"
      sha256 "1eae6a728db5767480a7066fbb5aaa736fc8c24788a30e3e6cc783dae8bdf00d"
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
