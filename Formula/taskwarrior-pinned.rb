class TaskwarriorPinned < Formula
  desc "TaskWarrior (pinned version for brainplorp compatibility)"
  homepage "https://taskwarrior.org"
  url "https://github.com/GothenburgBitFactory/taskwarrior.git",
      tag:      "v3.4.0",
      revision: "063325b0525ed523a32fd0b670f0de0aa65d40ac"
  license "MIT"
  head "https://github.com/GothenburgBitFactory/taskwarrior.git", branch: "3.0.0"

  depends_on "cmake" => :build
  depends_on "rust" => :build

  def install
    system "cmake", "-S", ".", "-B", "build", *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  def caveats
    <<~EOS
      This is a pinned version of TaskWarrior (3.4.0) for brainplorp compatibility.

      Why pinned?
      - TaskWarrior 3.4.1 has known issues (hangs on first run)
      - Version 3.4.0 tested and verified working on multiple Macs
      - See: https://github.com/dimatosj/brainplorp/blob/master/scripts/TASKWARRIOR_TESTING.md

      To upgrade TaskWarrior in the future:
      1. Test new version: /path/to/brainplorp/scripts/test_taskwarrior_version.sh vX.Y.Z
      2. Update this formula if tests pass
      3. Open PR in homebrew-brainplorp repo
    EOS
  end

  test do
    system "#{bin}/task", "--version"
  end
end
