import Foundation

extension FileManager {
    func listFiles(at url: URL) throws -> [URL] {
        try contentsOfDirectory(at: url,
                                includingPropertiesForKeys: nil,
                                options: .skipsHiddenFiles)
            .sorted(by: { (a, b) -> Bool in
                a.absoluteString < b.absoluteString
            })
    }
}
