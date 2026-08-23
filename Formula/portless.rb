# typed: strict
# frozen_string_literal: true

# Portless installs the local application-environment control plane.
class Portless < Formula
  desc "Local application-environment control plane"
  homepage "https://www.portless.run"
  url "https://github.com/runportless/portless/releases/download/v0.1.0-alpha.3/portless_0.1.0-alpha.3_source.tar.gz"
  sha256 "3fe4fc5e2e57404cad24f5cd47f5f15354cc287c2302ead15ee1cc521e3925fd"
  license "Apache-2.0"
  head "https://github.com/runportless/portless.git", branch: "main"

  depends_on "go" => :build
  depends_on :macos

  def install
    ldflags = %W[
      -X github.com/runportless/portless/portless-cli.Version=#{version}
      -X github.com/runportless/portless/portless-cli.Distribution=homebrew
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
