import Foundation
import Models

extension Book {
    static func from(file url: URL) throws -> Book {
        let fileLines = try String(contentsOf: url).components(separatedBy: "\n")
        let bookId = url.deletingPathExtension().lastPathComponent
        let title = fileLines[safe: 0].nilToEmpty()
        let author = fileLines[safe: 1].emptyToNil()
        let imageURL = fileLines[safe:2].flatMap { URL(string: $0) }
        
        let urls = (3..<fileLines.count)
            .compactMap { fileLines[safe: $0] }
            .compactMap { URL(string: $0) }

        return Book(id: bookId, title: title, author: author, coverImage: imageURL, urls: urls)
    }
}

extension Array where Element == Book {
    static func loadList(from urls: [URL]) throws -> [Book] {
        try urls.map {
            try Book.from(file: $0)
        }
    }
}



