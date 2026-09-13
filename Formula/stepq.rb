class Stepq < Formula
  desc "Query, inspect, split and reshape STEP (ISO 10303-21) files — a library and a CLI, no geometry kernel needed"
  homepage "https://github.com/jchultarsky/stepq"
  version "0.4.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/jchultarsky/stepq/releases/download/v0.4.0/stepq-aarch64-apple-darwin.tar.xz"
      sha256 "e81d5cb394f0a0016ed87cd0879d705edf8fbea18102c24ce9ddb5d31fd2855a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/jchultarsky/stepq/releases/download/v0.4.0/stepq-x86_64-apple-darwin.tar.xz"
      sha256 "021a3761ee6aef72b6d0f613049c5da9abdf4b4cefdaa01e00ec73080e51e4cc"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/jchultarsky/stepq/releases/download/v0.4.0/stepq-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "2a2c3ee11b8e5c7a2e56e3846fa61a91fdc573e48299c23a66193707dea29d2a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/jchultarsky/stepq/releases/download/v0.4.0/stepq-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "be77f695b7fb9b0a9692fca8c973e5c2efd690bf452a32b92fd1c5e766a78c69"
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
