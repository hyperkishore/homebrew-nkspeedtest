class Nkspeedtest < Formula
  desc "Internet speed monitoring with central dashboard aggregation"
  homepage "https://github.com/hyperkishore/speed-monitor"
  url "https://github.com/hyperkishore/speed-monitor/archive/refs/tags/v1.0.2.tar.gz"
  sha256 "afe53a4e2ae22328613cb62fe367ed155c662e54f63af0e74551c5ff2c72b0c1"
  license "MIT"

  depends_on "node"
  depends_on "speedtest-cli"

  def install
    # Install the Node.js script
    libexec.install Dir["*"]

    # Create wrapper script
    (bin/"nkspeedtest").write <<~EOS
      #!/bin/bash
      exec "#{Formula["node"].opt_bin}/node" "#{libexec}/bin/nkspeedtest" "$@"
    EOS
    chmod 0755, bin/"nkspeedtest"
  end

  def post_install
    ohai "nkspeedtest installed!"
    ohai "Setting up menu bar widget..."

    # Auto-run menubar setup
    system "#{bin}/nkspeedtest", "menubar"

    ohai "Run 'nkspeedtest setup' to configure your settings"
  end

  def caveats
    <<~EOS
      To get started:
        nkspeedtest setup

      To start automatic monitoring:
        nkspeedtest start

      Menu bar widget was auto-installed. If not visible:
        nkspeedtest menubar

      To update:
        brew upgrade nkspeedtest
    EOS
  end

  test do
    assert_match "nkspeedtest", shell_output("#{bin}/nkspeedtest --version")
  end
end
