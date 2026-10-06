class Finnest < Formula
  desc "Finnest Customer CLI"
  homepage "https://finnest.com.br"
  version "0.15.6"
  license "UNLICENSED"

  resource "finnest-runtime" do
    on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.15.6/finnest-runtime-darwin-arm64.tar.gz"
      sha256 "491ba000a15f36a5e7ce2182416813fa861e41d41a03595b5eac4f14b6d6b424"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.15.6/finnest-runtime-darwin-x64.tar.gz"
      sha256 "a7a6a9dde1fa316c1aa6bcbff8df661166b5735faa6de574f95dcda0fd707caf"
    end
    end
    on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.15.6/finnest-runtime-linux-arm64.tar.gz"
      sha256 "d586e9152bbd0af108dc2faeaf861e73e7a289952b70de824f8e1d974af7c470"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.15.6/finnest-runtime-linux-amd64.tar.gz"
      sha256 "868091aba3754a4d90c53bf615678703cdbaf760ecede472c6f0f495c411ed0d"
    end
    end
  end

  on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.15.6/finnest-darwin-arm64.gz"
      sha256 "90614a0c31b4f528c4138087abe813fdd190761abd430f0b15af5720a2add586"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.15.6/finnest-darwin-x64.gz"
      sha256 "4898c0685e18e70e3788269d9698f2044097117a5026fe7b09ac2676d0046d06"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.15.6/finnest-linux-arm64.gz"
      sha256 "168cf648e38ef9155a5d982c2a9d695008998c464c54c35bf30d536793701e6b"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.15.6/finnest-linux-amd64.gz"
      sha256 "b6d0f715b10157f41d5f467001ac5235a9e28b3cfb4831e6cadb9b4e7eeaa1e7"
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
