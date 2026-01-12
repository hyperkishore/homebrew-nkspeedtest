class Nkspeedtest < Formula
  desc "Internet speed monitoring with central dashboard aggregation"
  homepage "https://github.com/hyperkishore/speed-monitor"
  url "https://github.com/hyperkishore/speed-monitor/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "b8d9e745c1e954b2417a7f2390eb94a105cebb8978fad8057c892df642d359ac"
  license "MIT"

  depends_on "speedtest-cli"

  def install
    bin.install "bin/speed-monitor" => "nkspeedtest"
  end

  def post_install
    ohai "nkspeedtest installed!"
    ohai "Run 'nkspeedtest setup' to configure"
  end

  def caveats
    <<~EOS
      To get started:
        nkspeedtest setup

      To start automatic monitoring:
        nkspeedtest start

      To view status:
        nkspeedtest status

      To open the local dashboard:
        nkspeedtest dashboard
    EOS
  end

  test do
    assert_match "speed-monitor", shell_output("#{bin}/nkspeedtest --version")
  end
end
