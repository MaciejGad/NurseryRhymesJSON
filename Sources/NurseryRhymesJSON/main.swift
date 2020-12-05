import Models
import Foundation

let fileManger = FileManager.default
let rhymeDir = URL(fileURLWithPath: "rhymes")

do {
    let rhymeFilesURLs = try fileManger.contentsOfDirectory(at: rhymeDir, includingPropertiesForKeys: nil, options: .skipsHiddenFiles).sorted(by: { (a, b) -> Bool in
        a.absoluteString < b.absoluteString
    })
    print("Found \(rhymeFilesURLs.count) files:")
    let fileNames = rhymeFilesURLs.map { $0.lastPathComponent }.joined(separator: "\n")
    print(fileNames)
    
    var rhymes: [Rhyme] = []
    for fileURL in rhymeFilesURLs {
        let fileLines = try String(contentsOf: fileURL).components(separatedBy: "\n")
        let rhymeId = fileURL.deletingPathExtension().lastPathComponent
        let title = fileLines[safe: 0] ?? ""
        var author = fileLines[safe: 1]
        if author != nil, author?.count == 0 {
            author = nil
        }
        let image = fileLines[2]
        let imageURL = URL(string: "https://maciejgad.github.io/NurseryRhymesJSON/images/\(image)")
        var text = ""
        for index in 3..<fileLines.count {
            guard let line = fileLines[safe: index] else {
                break
            }
            text.append(line)
            text.append("\n")
        }
        text.removeLast() //remove last new line
        let rhyme = Rhyme(id: rhymeId, title: title, author: author, text: text, image: imageURL)
        rhymes.append(rhyme)
    }
    let list = List(results: rhymes.map { $0.toListItem() })
    let jsonEncoder = JSONEncoder()
    for rhyme in rhymes {
        do {
            let data = try jsonEncoder.encode(rhyme)
            let outURL = URL(fileURLWithPath: "docs/data/\(rhyme.id).json")
            try data.write(to: outURL)
        } catch  {
            print("\(error)", to:&standardError)
        }
    }
    let data = try jsonEncoder.encode(list)
    let outURL = URL(fileURLWithPath: "docs/data/list.json")
    try data.write(to: outURL)
    print(list)
} catch {
    print("\(error)", to:&standardError)
    exit(EXIT_FAILURE)
}
