import Foundation

extension Array where Element == URL {
    func filesNames() -> [String] {
        map { $0.lastPathComponent }
    }
}
