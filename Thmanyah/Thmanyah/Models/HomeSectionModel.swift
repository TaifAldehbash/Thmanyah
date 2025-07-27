struct HomeSection: Codable, Identifiable {
    var id: String { name + String(order) }
    let name: String
    let type: SectionLayout
    let content_type: ContentType
    let order: Int
    let content: [ContentItem]
}

enum SectionLayout: String, Codable {
    case square
    case twoLinesGrid = "2_lines_grid"
    case bigSquare = "big square"
    case queue
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let raw = try container.decode(String.self)
        
        switch raw {
            case "square":
                self = .square
            case "2_lines_grid":
                self = .twoLinesGrid
            case "big_square", "big square":
                self = .bigSquare
            case "queue":
                self = .queue
            default:
                throw DecodingError.dataCorruptedError(in: container,
                                                       debugDescription: "Unknown section type: \(raw)")
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
            case .square: try container.encode("square")
            case .twoLinesGrid: try container.encode("2_lines_grid")
            case .bigSquare: try container.encode("big_square")
            case .queue: try container.encode("queue")
        }
    }
}

enum ContentType: String, Codable {
    case podcast
    case episode
    case audioBook = "audio_book"
    case audioArticle = "audio_article"
}
