import Foundation

public enum CodexResource {
  public static var binaryURL: URL {
    guard let baseURL = Bundle.module.resourceURL else {
      fatalError("Missing Codex resource directory. Run Scripts/update_codex_resource.sh.")
    }
    return baseURL.appendingPathComponent("codex-aarch64-apple-darwin")
  }
}
