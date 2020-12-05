import Foundation

final class Writer {
    private lazy var jsonEncoder = JSONEncoder()
    
    func save<T: Encodable>(_ item: T, filename: String) throws {
        let data = try jsonEncoder.encode(item)
        let outURL = URL(fileURLWithPath: "docs/data/\(filename).json")
        try data.write(to: outURL)
    }
    
    func save<T: Encodable>(_ items: [T], filenames: (T) -> String) throws {
        for item in items {
            try save(item, filename: filenames(item))
        }
    }

}

