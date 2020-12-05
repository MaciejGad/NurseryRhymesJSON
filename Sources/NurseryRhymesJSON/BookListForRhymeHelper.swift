import Foundation
import Models

extension Array where Element == BookListForRhyme {
    static func from(file url: URL, books: [Book]) throws -> [BookListForRhyme] {
        let bookByID = books.reduce(into: [:]) {
            $0[$1.id] = $1
        }
        var list: [BookListForRhyme] = []
        let mappings = try String(contentsOf: url).components(separatedBy: "\n")
        for mapping in mappings {
            let elements = mapping.components(separatedBy: " ")
            guard let rhymeId = elements[safe: 0] else {
                continue
            }
            let books = (1..<elements.count)
                .compactMap { elements[safe: $0] }
                .compactMap { bookByID[$0] }
            guard books.count > 0 else {
                continue
            }
            list.append(.init(rhymeId: rhymeId, books: books))
        }
        return list
    }
}
