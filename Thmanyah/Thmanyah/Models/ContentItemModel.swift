import Foundation

struct ContentItem: Identifiable, Codable {
    let id: String
    let name: String
    let description: String?
    let avatar_url: String
    let author_name: String?
    let duration: Int?
    let priority: Int?
    let episode_count: Int?
    
    var formattedDuration: String? {
        guard let duration = duration else { return nil }
        print("\n\n Duration: \(duration)")
        let hours = duration / 3600
        let minutes = (duration % 3600) / 60
        
        switch (hours, minutes) {
            case (0, 0): return nil
            case (0, let m): return "\(m) min"
            case (let h, 0): return "\(h) h"
            default: return "\(hours) h \(minutes) min"
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case name, description, avatar_url, author_name, duration, priority, episode_count
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
        duration = try? container.decode(Int.self, forKey: .duration)
        priority = try? container.decode(Int.self, forKey: .priority)
        episode_count = try? container.decode(Int.self, forKey: .episode_count)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encodeIfPresent(description, forKey: .description)
        try container.encode(avatar_url, forKey: .avatar_url)
        try container.encodeIfPresent(author_name, forKey: .author_name)
        try container.encodeIfPresent(duration, forKey: .duration)
        try container.encodeIfPresent(priority, forKey: .priority)
        try container.encodeIfPresent(episode_count, forKey: .episode_count)
    }
}
