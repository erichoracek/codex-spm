import Foundation

public enum CodexZshResource {
  public static var binaryURL: URL {
    guard let baseURL = Bundle.module.resourceURL else {
      fatalError("Missing Codex zsh resource directory. Run Scripts/update_codex_resource.sh.")
    }
    return baseURL.appendingPathComponent("zsh")
  }
}
