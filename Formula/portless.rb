# typed: strict
# frozen_string_literal: true

# Portless installs the local application-environment control plane.
class Portless < Formula
  desc "Local application-environment control plane"
  homepage "https://www.portless.run"
  url "https://github.com/runportless/portless/releases/download/v0.1.0-alpha.4/portless_0.1.0-alpha.4_source.tar.gz"
  sha256 "98e2d091d21d58adf1d7d3673720d2f8606225a6236d5f6eeb570266e77465cc"
  license "Apache-2.0"
  head "https://github.com/runportless/portless.git", branch: "main"

  depends_on "go" => :build
  depends_on :macos

  def install
    ldflags = %W[
      -X github.com/runportless/portless/portless-cli.Version=#{version}
      -X github.com/runportless/portless/portless-cli.Distribution=homebrew
      -X github.com/runportless/portless/portless-cli.Commit=5096b931665d054f54b1482649c54ca4752ac34f
    ]
    system "go", "build", *std_go_args(ldflags: ldflags, output: bin/"portless"), "./portless-cli/cmd/portless"
    generate_completions_from_executable(bin/"portless", "completion")
  end

  def caveats
    <<~EOS
      Run `portless setup` once after installation. It installs the privileged
      loopback relay used for clean HTTP URLs and portless.test DNS.

      Before removing the formula, clean up Portless-owned state with:
        portless uninstall --yes
        brew uninstall runportless/tap/portless
    EOS
  end

  test do
    assert_equal "portless #{version}\n", shell_output("#{bin}/portless --version")
    assert_match %Q("version": "#{version}"), shell_output("#{bin}/portless --version --json")
    assert_match "#compdef portless", shell_output("#{bin}/portless completion zsh")
  end
end
