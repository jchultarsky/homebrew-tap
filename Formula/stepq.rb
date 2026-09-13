class Stepq < Formula
  desc "Query, inspect, split and reshape STEP (ISO 10303-21) files — a library and a CLI, no geometry kernel required"
  homepage "https://github.com/jchultarsky/stepq"
  version "0.3.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/jchultarsky/stepq/releases/download/v0.3.0/stepq-aarch64-apple-darwin.tar.xz"
      sha256 "cf8e1367418aca61fd2ab078e001bf1406337530e33931a7d56e80afc45581aa"
    end
    if Hardware::CPU.intel?
      url "https://github.com/jchultarsky/stepq/releases/download/v0.3.0/stepq-x86_64-apple-darwin.tar.xz"
      sha256 "a5366e353504da18b88c9c3029b8e529573e444c4e295dfac459b3f37326ce86"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/jchultarsky/stepq/releases/download/v0.3.0/stepq-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "75494a71bfa45858e0a8b497c98c2eab747ed7c29322d261dfab59574df7f333"
    end
    if Hardware::CPU.intel?
      url "https://github.com/jchultarsky/stepq/releases/download/v0.3.0/stepq-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "87d15ea9c4bdab5dbf2f838203a7af1d9e9050c999ae1106a2f8b63432fa9ccd"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":              {},
    "aarch64-unknown-linux-gnu":         {},
    "x86_64-apple-darwin":               {},
    "x86_64-pc-windows-gnu":             {},
    "x86_64-unknown-linux-gnu":          {},
    "x86_64-unknown-linux-musl-dynamic": {},
    "x86_64-unknown-linux-musl-static":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "stepq"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "stepq"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "stepq"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "stepq"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
