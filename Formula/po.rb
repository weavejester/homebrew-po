require "language/go"

class Po < Formula
  desc "A command-line tool for organizing project-specific scripts"
  homepage "https://github.com/weavejester/po"
  url "https://github.com/weavejester/po/archive/0.1.1.tar.gz"
  sha256 "b6cb6c71c4d0e184b7429379d58948925bf500164489ce845a098a03294e1281"

  bottle do
    root_url "https://homebrew.bintray.com/bottles-po"
    cellar :any_skip_relocation
    sha256 "685b3f6ece7e5050344812495e53d7e53796e53456585f533cfba13aa9bc5d31" => :mojave
  end

  depends_on "go" => :build

  go_resource "github.com/fatih/color" do
    url "https://github.com/fatih/color.git",
        :revision => "3f9d52f7176a6927daacff70a3e8d1dc2025c53e"
  end

  go_resource "github.com/spf13/cobra" do
    url "https://github.com/spf13/cobra.git",
        :revision => "fe5e611709b0c57fa4a89136deaa8e1d4004d053"
  end

  go_resource "github.com/spf13/pflag" do
    url "https://github.com/spf13/pflag.git",
        :revision => "aea12ed6721610dc6ed40141676d7ab0a1dac9e9"
  end

  go_resource "golang.org/x/sys" do
    url "https://go.googlesource.com/sys.git",
        :revision => "62eef0e2fa9b2c385f7b2778e763486da6880d37"
  end

  go_resource "gopkg.in/yaml.v2" do
    url "https://gopkg.in/yaml.v2.git",
        :revision => "5420a8b6744d3b0345ab293f6fcba19c978f1183"
  end

  def install
    ENV["GOPATH"] = buildpath
    (buildpath/"src/github.com/weavejester/po").install buildpath.children
    Language::Go.stage_deps resources, buildpath/"src"
    cd "src/github.com/weavejester/po" do
      system "go", "build", "-o", bin/"po"
      prefix.install_metafiles
    end
  end

  test do
    assert_match "po version #{version}", shell_output("#{bin}/po --version")
  end
end
