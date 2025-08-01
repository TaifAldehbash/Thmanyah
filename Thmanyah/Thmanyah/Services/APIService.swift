import Foundation

protocol APIServiceProtocol {
    func fetchHomeSections(from urlString: String?) async throws -> (sections: [HomeSection], nextPage: String?)
    func search(query: String) async throws -> [HomeSection]
}

extension APIService: APIServiceProtocol {}

class APIService {
    static let shared = APIService()
    private init() {}
    
    func fetchHomeSections(from urlString: String? = nil) async throws -> (sections: [HomeSection], nextPage: String?) {
        let urlString = urlString ?? "https://api-v2-b2sit6oh3a-uc.a.run.app/home_sections"
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let decoded = try JSONDecoder().decode(PaginatedHomeSections.self, from: data)
        return (decoded.sections, decoded.pagination.next_page)
    }
    
    func search(query: String) async throws -> [HomeSection] {
        let url = URL(string: "https://mock.apidog.com/m1/735111-711675-default/search?q=\(query)")!
        let (data, _) = try await URLSession.shared.data(from: url)
        
        struct Root: Decodable {
            let sections: [HomeSection]
        }
        
        let decoded = try JSONDecoder().decode(Root.self, from: data)
        return decoded.sections
    }
}
