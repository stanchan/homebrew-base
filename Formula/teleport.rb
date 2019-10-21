class Teleport < Formula
    desc "Modern SSH server for teams managing distributed infrastructure"
    homepage "https://gravitational.com/teleport"
    url "https://github.com/stanchan/teleport/archive/v4.1.2.tar.gz"
    sha256 "5c5a75f45cea6db6d668d3d8a0f1d5d51dea52c9d07cf80075fc25cb72f3491c"
    head "https://github.com/stanchan/teleport.git"

    bottle do
      cellar :any_skip_relocation
      root_url "https://dl.bintray.com/stanchan/bottles"
      sha256 "734c635c0eb82d244b2226e0a4b97ffd0fb416226614a39942712a0fbb8b45b0" => :mojave
    end

    depends_on "go" => :build

    conflicts_with "etsh", :because => "both install `tsh` binaries"

    def install
      ENV["GOOS"] = "darwin"
      ENV["GOARCH"] = "amd64"
      ENV["GOPATH"] = buildpath
      ENV["GOROOT"] = Formula["go"].opt_libexec

      (buildpath / "src/github.com/gravitational/teleport").install buildpath.children
      ln_s buildpath/"src", buildpath / "src/github.com/gravitational/teleport"

      cd "src/github.com/gravitational/teleport" do
        ENV.deparallelize { system "make", "release" }
        system "/usr/bin/tar", "-xvf", "teleport-v#{version}-#{ENV["GOOS"]}-#{ENV["GOARCH"]}-bin.tar.gz"
        cd "teleport" do
          bin.install %w[teleport tctl tsh]
          prefix.install_metafiles
        end
      end
    end

    test do
      assert_match version.to_s, shell_output("#{bin}/teleport version")
      assert_match version.to_s, shell_output("#{bin}/tctl version")
      assert_match version.to_s, shell_output("#{bin}/tsh version")
      (testpath/"config.yml").write shell_output("#{bin}/teleport configure")
        .gsub("0.0.0.0", "127.0.0.1")
        .gsub("/var/lib/teleport", testpath)
        .gsub("/var/run", testpath)
        .gsub(/https_(.*)/, "")
      begin
        pid = spawn("#{bin}/teleport start -c #{testpath}/config.yml")
        sleep 5
        system "/usr/bin/curl", "--insecure", "https://localhost:3080"
        system "/usr/bin/nc", "-z", "localhost", "3022"
        system "/usr/bin/nc", "-z", "localhost", "3023"
        system "/usr/bin/nc", "-z", "localhost", "3025"
      ensure
        Process.kill(9, pid)
      end
    end
  end