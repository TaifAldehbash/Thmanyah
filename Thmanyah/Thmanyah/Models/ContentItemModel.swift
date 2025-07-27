import Foundation

struct ContentItem: Identifiable, Codable {
    let id: String
    let name: String
    let description: String?
    let avatar_url: String
    let author_name: String?
    
    enum CodingKeys: String, CodingKey {
        case name, description, avatar_url, author_name
        case podcast_id, episode_id, audiobook_id, article_id
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        if let podcastID = try? container.decode(String.self, forKey: .podcast_id) {
            id = podcastID
        } else if let episodeID = try? container.decode(String.self, forKey: .episode_id) {
            id = episodeID
        } else if let audioBookID = try? container.decode(String.self, forKey: .audiobook_id) {
            id = audioBookID
        } else if let articleID = try? container.decode(String.self, forKey: .article_id) {
            id = articleID
        } else {
            id = UUID().uuidString
        }
        
        name = try container.decode(String.self, forKey: .name)
        description = try? container.decode(String.self, forKey: .description)
        avatar_url = try container.decode(String.self, forKey: .avatar_url)
        author_name = try? container.decode(String.self, forKey: .author_name)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encodeIfPresent(description, forKey: .description)
        try container.encode(avatar_url, forKey: .avatar_url)
        try container.encodeIfPresent(author_name, forKey: .author_name)
    }
}
