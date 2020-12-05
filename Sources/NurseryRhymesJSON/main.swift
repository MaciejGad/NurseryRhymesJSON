import Models
import Foundation

let fileManger = FileManager.default
let rhymesDir = URL(fileURLWithPath: "rhymes")
let booksDir = URL(fileURLWithPath: "books")


do {
    //list rhymes
    let rhymeFilesURLs = try fileManger.listFiles(at: rhymesDir)
    print("Found \(rhymeFilesURLs.count) rhymes:")
    let filesNames = rhymeFilesURLs.filesNames().joined(separator: "\n")
    print(filesNames)
    
    //load rhymes
    let rhymes: [Rhyme] = try .loadList(from: rhymeFilesURLs)
    let list = List(results: rhymes.toListItems())
    
    //list books
    let booksFilesURLs = try fileManger.listFiles(at: booksDir)
    print("Found \(booksFilesURLs.count) books:")
    let bookFilesNames = booksFilesURLs.filesNames().joined(separator: "\n")
    print(bookFilesNames)
    
    //load books
    let books: [Book] = try .loadList(from: booksFilesURLs)
    
    //load book list for rhyme
    let bookListsForRhymeURL = URL(fileURLWithPath: "bookListsForRhyme.txt")
    let bookList: [BookListForRhyme] = try .from(file: bookListsForRhymeURL, books: books)
    
    //save all
    let writer = Writer()
    
    try writer.save(rhymes, filenames: { $0.id })
    try writer.save(list, filename: "list")
    try writer.save(bookList, filenames: { "books/\($0.rhymeId)" })
    
    //print summary
    print(list.results.map { $0.title }.joined(separator: ", "))
    print(books.map { $0.title }.joined(separator: ", "))
    
} catch {
    print("\(error)", to:&standardError)
    exit(EXIT_FAILURE)
}
