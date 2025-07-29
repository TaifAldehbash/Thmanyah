struct HomeSection: Codable, Identifiable {
    var id: String { name + String(order ?? -1) }
    let name: String
    let type: SectionLayout
    let content_type: ContentType
    let order: Int?
    let content: [ContentItem]
    
    enum CodingKeys: String, CodingKey {
        case name, type, content_type, order, content
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        name = try container.decode(String.self, forKey: .name)
        type = try container.decode(SectionLayout.self, forKey: .type)
        content_type = try container.decode(ContentType.self, forKey: .content_type)
        content = try container.decode([ContentItem].self, forKey: .content)
        
        // Try decoding order as Int or String, fallback to nil
        if let intValue = try? container.decode(Int.self, forKey: .order) {
            order = intValue
        } else if let stringValue = try? container.decode(String.self, forKey: .order),
                  let intFromString = Int(stringValue) {
            order = intFromString
        } else {
            order = nil
        }
    }
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
                self = .square
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
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let rawValue = try container.decode(String.self)
        self = ContentType(rawValue: rawValue) ?? .podcast
    }
}
