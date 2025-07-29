import XCTest
@testable import Thmanyah

extension HomeViewModel {
    func setNextPageForTesting(_ url: String?) {
        self.nextPage = url
    }
}

final class HomeViewModelTests: XCTestCase {
    class MockAPIService: APIServiceProtocol {
        var fetchSectionsCalled = false
        var nextPageUsed: String?
        var mockSections: [HomeSection] = []
        var mockNextPage: String? = nil
        
        func fetchHomeSections(from urlString: String?) async throws -> (sections: [HomeSection], nextPage: String?) {
            if let url = urlString {
                nextPageUsed = url
            } else {
                fetchSectionsCalled = true
            }
            return (mockSections, mockNextPage)
        }
        
        func search(query: String) async throws -> [HomeSection] {
            return []
        }
    }
    
    func testLoadInitialSectionsSuccess() async {
        let mockService = MockAPIService()
        mockService.mockSections = [HomeSection.mock(name: "Test")]
        let viewModel = await HomeViewModel(apiService: mockService)
        
        await viewModel.loadInitialSections()
        
        XCTAssertTrue(mockService.fetchSectionsCalled)
        await MainActor.run {
            XCTAssertEqual(viewModel.sections.count, 1)
            XCTAssertEqual(viewModel.sections.first?.name, "Test")
        }
    }
    
    func testLoadMoreSectionsIfNeeded() async {
        let mockService = MockAPIService()
        let section = HomeSection.mock(name: "Test")
        mockService.mockSections = [section]
        mockService.mockNextPage = nil
        
        let viewModel = await HomeViewModel(apiService: mockService)
        await MainActor.run {
            viewModel.sections = [section]
            viewModel.setNextPageForTesting("/home_sections?page=2")
        }
        
        await viewModel.loadMoreSectionsIfNeeded(currentItem: section)
        
        XCTAssertEqual(
            mockService.nextPageUsed,
            "https://api-v2-b2sit6oh3a-uc.a.run.app/home_sections?page=2"
        )
    }
}
