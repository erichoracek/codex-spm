import XCTest
@testable import CodexZshBinary

final class CodexZshBinaryTests: XCTestCase {
  func testBinaryURLExists() throws {
    let url = CodexZshResource.binaryURL
    XCTAssertTrue(url.isFileURL, "binaryURL should be a file URL")

    let exists = FileManager.default.fileExists(atPath: url.path)
    XCTAssertTrue(
      exists,
      "Expected Codex zsh binary at \(url.path). Run Scripts/update_codex_resource.sh."
    )
  }
}
