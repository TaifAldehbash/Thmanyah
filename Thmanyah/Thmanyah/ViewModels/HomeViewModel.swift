import Foundation
import UIKit

@MainActor
class HomeViewModel: ObservableObject {
    @Published var sections: [HomeSection] = []
    @Published var isLoading = false
    internal var nextPage: String?
    
    private let apiService: APIServiceProtocol
    
    init(apiService: APIServiceProtocol = APIService.shared) {
        self.apiService = apiService
    }
    
    func loadInitialSections() async {
        isLoading = true
        do {
            let (fetchedSections, next) = try await apiService.fetchHomeSections(from: nil)
            self.sections = fetchedSections
            self.nextPage = next
        } catch {
            print("Error fetching sections: \(error)")
        }
        isLoading = false
    }
    
    func loadMoreSectionsIfNeeded(currentItem section: HomeSection) async {
        guard let last = sections.last, last.id == section.id,
              let nextPage = nextPage, !isLoading else { return }
        
        isLoading = true
        do {
            let (fetchedSections, next) = try await apiService.fetchHomeSections(from: "https://api-v2-b2sit6oh3a-uc.a.run.app\(nextPage)")
            self.sections.append(contentsOf: fetchedSections)
            self.nextPage = next
        } catch {
            print("Error loading more: \(error)")
        }
        isLoading = false
    }
}
