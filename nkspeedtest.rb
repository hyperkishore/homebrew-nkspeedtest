class Nkspeedtest < Formula
  desc "Internet speed monitoring with central dashboard aggregation"
  homepage "https://github.com/hyperkishore/speed-monitor"
  url "https://github.com/hyperkishore/speed-monitor/archive/refs/tags/v1.0.3.tar.gz"
  sha256 "ae8108a993fa5b9dbe7684378d074ff8b00c17e14f7a951e56517eac0936b93e"
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
