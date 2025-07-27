import Foundation

class APIService {
    static let shared = APIService()
    private init() {}
    
    func fetchHomeSections() async throws -> [HomeSection] {
        let url = URL(string: "https://api-v2-b2sit6oh3a-uc.a.run.app/home_sections")!
        let (data, _) = try await URLSession.shared.data(from: url)
        
        struct Root: Decodable {
            let sections: [HomeSection]
        }
        
        let decoded = try JSONDecoder().decode(Root.self, from: data)
        return decoded.sections
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
