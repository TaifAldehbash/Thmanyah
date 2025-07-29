import SwiftUI

@MainActor
class SearchViewModel: ObservableObject {
    @Published var query: String = ""
    @Published var results: [HomeSection] = []
    @Published var isLoading = false
    @Published var isEmpty = false
    
    private let debouncer = Debouncer()
    
    private let apiService: APIServiceProtocol
    
    init(apiService: APIServiceProtocol = APIService.shared) {
        self.apiService = apiService
    }
    
    func onQueryChanged(_ newValue: String) {
        debouncer.debounce(delay: 0.2) {
            Task { await self.performSearch() }
        }
    }
    
    func performSearch() async {
        guard !query.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            results = []
            isEmpty = false
            return
        }
        
        isLoading = true
        do {
            let fetched = try await apiService.search(query: query)
            results = fetched
            isEmpty = fetched.isEmpty
        } catch {
            print("Error: \(error)")
            results = []
            isEmpty = true
        }
        isLoading = false
    }
}
