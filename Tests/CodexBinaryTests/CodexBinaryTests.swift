import XCTest
@testable import CodexBinary

final class CodexBinaryTests: XCTestCase {
  func testBinaryURLExists() throws {
    let url = CodexResource.binaryURL
    XCTAssertTrue(url.isFileURL, "binaryURL should be a file URL")

    let exists = FileManager.default.fileExists(atPath: url.path)
    XCTAssertTrue(
      exists,
      "Expected Codex binary at \(url.path). Run Scripts/update_codex_resource.sh."
    )
  }
}
