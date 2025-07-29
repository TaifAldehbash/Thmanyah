import XCTest
@testable import Thmanyah

extension HomeSection {
    static func mock(
        name: String = "Test Section",
        type: SectionLayout = .square,
        content_type: ContentType = .podcast,
        order: Int? = 0,
        content: [ContentItem] = []
    ) -> HomeSection {
        return try! JSONDecoder().decode(
            HomeSection.self,
            from: """
            {
                "name": "\(name)",
                "type": "\(type.rawValue)",
                "content_type": "\(content_type.rawValue)",
                "order": \(order ?? -1),
                "content": []
            }
            """.data(using: .utf8)!
        )
    }
}

final class SearchViewModelTests: XCTestCase {
    
    class MockAPIService: APIServiceProtocol {
        func fetchHomeSections(from urlString: String?) async throws -> (sections: [Thmanyah.HomeSection], nextPage: String?) {
            return ([], nil)
        }
        
        var searchQuery: String?
        var resultToReturn: [HomeSection] = []
        var shouldThrowError = false
        
        func search(query: String) async throws -> [HomeSection] {
            searchQuery = query
            if shouldThrowError {
                throw URLError(.badServerResponse)
            }
            return resultToReturn
        }
    }
    
    func testPerformSearchWithEmptyQuery() async {
        let mockService = MockAPIService()
        let viewModel = await SearchViewModel(apiService: mockService)
        
        await MainActor.run {
            viewModel.query = "   "
        }
        await viewModel.performSearch()
        
        await MainActor.run {
            XCTAssertTrue(viewModel.results.isEmpty)
            XCTAssertFalse(viewModel.isEmpty)
        }
    }
    
    func testPerformSearchWithResults() async {
        let mockService = MockAPIService()
        mockService.resultToReturn = [
            HomeSection.mock(name: "Result")
        ]
        let viewModel = await SearchViewModel(apiService: mockService)
        
        await MainActor.run {
            viewModel.query = "test"
        }
        await viewModel.performSearch()
        
        await MainActor.run {
            XCTAssertEqual(viewModel.results.count, 1)
            XCTAssertEqual(mockService.searchQuery, "test")
            XCTAssertFalse(viewModel.isEmpty)
        }
    }
    
    func testPerformSearchWithError() async {
        let mockService = MockAPIService()
        mockService.shouldThrowError = true
        let viewModel = await SearchViewModel(apiService: mockService)
        
        await MainActor.run {
            viewModel.query = "error"
        }
        await viewModel.performSearch()
        
        await MainActor.run {
            XCTAssertTrue(viewModel.results.isEmpty)
            XCTAssertTrue(viewModel.isEmpty)
        }
    }
}
