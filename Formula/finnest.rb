class Finnest < Formula
  desc "Finnest Customer CLI"
  homepage "https://finnest.com.br"
  version "0.19.13"
  license "UNLICENSED"

  resource "finnest-runtime" do
    on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.13/finnest-runtime-darwin-arm64.tar.gz"
      sha256 "2fb096194da04dc66b8252bb0e516116a48161e658c248a03e0ec39d982f3bd2"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.13/finnest-runtime-darwin-x64.tar.gz"
      sha256 "a1905d4b2dff0ac03d1f3a8b848f9220aed2a79f5d9b16fb512a8ebbd11e7035"
    end
    end
    on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.13/finnest-runtime-linux-arm64.tar.gz"
      sha256 "669e21f01702ec70c5cded51d3114c7353eaf3efba8523ef903d020359c9468b"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.13/finnest-runtime-linux-amd64.tar.gz"
      sha256 "e9c996fb760b02a0973924957761cc85ee96a9f31374998f6989eff50dce4bc4"
    end
    end
  end

  on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.13/finnest-darwin-arm64.gz"
      sha256 "224c2af596d75da1fe47c2a866e1ffab811ab45aed13e425bcd80bb787924bdd"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.13/finnest-darwin-x64.gz"
      sha256 "79c4884169f1f299d1909ec6589b96f5d5ff931568953943c7290634a0a1b360"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.13/finnest-linux-arm64.gz"
      sha256 "d8fd926ad871426b515b70251a83a63c588c38a94e77969d2c4f51faf2e17cb1"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.13/finnest-linux-amd64.gz"
      sha256 "42dfda2136bbaa7d743e451348c73c377abf594b74a691dbe9c8eb3c08261d58"
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
