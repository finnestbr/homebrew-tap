class Finnest < Formula
  desc "Finnest Customer CLI"
  homepage "https://finnest.com.br"
  version "0.19.21"
  license "UNLICENSED"

  resource "finnest-runtime" do
    on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.21/finnest-runtime-darwin-arm64.tar.gz"
      sha256 "58f627a9cb6c89c96b58c3b636c755eaa57699f08f7b198300f5a05f5a990e9f"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.21/finnest-runtime-darwin-x64.tar.gz"
      sha256 "1701de995b6aa7928785be3aa96cf430a5aab803cae00dec24965c27789538be"
    end
    end
    on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.21/finnest-runtime-linux-arm64.tar.gz"
      sha256 "64e71f95690f11d57254802314d935d1c3f544f2f4e12b7be845ad334615e6a4"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.21/finnest-runtime-linux-amd64.tar.gz"
      sha256 "79ebd9a100931594a086a6e330a98a077f73023f569bed1d092579fddeffc077"
    end
    end
  end

  on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.21/finnest-darwin-arm64.gz"
      sha256 "1175fc607e514e289f0b3970617048416839a5ef539baa540d8c6d76ec15408f"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.21/finnest-darwin-x64.gz"
      sha256 "d9aa5adc6a2bfee03cda9c17106174f7792d0182833cd6e3230577eefef6f650"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.21/finnest-linux-arm64.gz"
      sha256 "829a977d27973ff75af90200bc1deaee53bdcf5745ddbe85d5989e31ed216a7b"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.21/finnest-linux-amd64.gz"
      sha256 "8c16e6852f4b7259da1ecd3e029a4083f1700d49d1759b68751826a1391ba770"
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
