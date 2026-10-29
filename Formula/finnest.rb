class Finnest < Formula
  desc "Finnest Customer CLI"
  homepage "https://finnest.com.br"
  version "0.28.7"
  license "UNLICENSED"

  resource "finnest-runtime" do
    on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.28.7/finnest-runtime-darwin-arm64.tar.gz"
      sha256 "7e2615dd78fc0bf2186a7cf0f3d8e6d0dd503a951b1725cdcc2cc80dc08c2aaf"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.28.7/finnest-runtime-darwin-x64.tar.gz"
      sha256 "6733b68d90750db88024ba1c041136136aad93889d6df44e5cc3d618bb82b9e8"
    end
    end
    on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.28.7/finnest-runtime-linux-arm64.tar.gz"
      sha256 "2c22ac9bd4fe9100d7523d222defe76e7d36fd7c02cab69e344cd40b6818de65"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.28.7/finnest-runtime-linux-amd64.tar.gz"
      sha256 "f6a3480f7e8028c072a4210461230ca75d55f1c9aced35ff6b33b71c04bf3913"
    end
    end
  end

  on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.28.7/finnest-darwin-arm64.gz"
      sha256 "ff11bac1dff8d884752bb82432571a27918a1bf5726726c934108dcd1f9ee369"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.28.7/finnest-darwin-x64.gz"
      sha256 "a319559f38c149ee921ff9dc8eb48d6fabcea94012605fd3ede0382594464401"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.28.7/finnest-linux-arm64.gz"
      sha256 "69e62ac5ad623ffcb210b0e07eaba94329c4581345bc5dbac61e9525abd690bf"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.28.7/finnest-linux-amd64.gz"
      sha256 "32ccdedea32d29aac712c7e3018b4e687278454b8e7e372278668df859314b15"
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
