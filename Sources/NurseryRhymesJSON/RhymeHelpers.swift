import Foundation
import Models

extension Rhyme {
    static func from(file url: URL) throws -> Rhyme {
        let fileLines = try String(contentsOf: url).components(separatedBy: "\n")
        let rhymeId = url.deletingPathExtension().lastPathComponent
        let title = fileLines[safe: 0].nilToEmpty()
        let author = fileLines[safe: 1].emptyToNil()
        let imageURL = fileLines[safe:2]
            .flatMap { URL(string: "https://maciejgad.github.io/NurseryRhymesJSON/images/\($0)")}
        let text = (3..<fileLines.count)
            .compactMap { fileLines[safe: $0] }
            .joined(separator: "\n")
        return Rhyme(id: rhymeId, title: title, author: author, text: text, image: imageURL)
    }
}

extension Array where Element == Rhyme {
    static func loadList(from urls: [URL]) throws -> [Rhyme] {
        try urls.map {
            try Rhyme.from(file: $0)
        }
    }
    
    func toListItems() -> [ListItem] {
        map { $0.toListItem() }
    }
}


