import Foundation

@MainActor
class HomeViewModel: ObservableObject {
    @Published var sections: [HomeSection] = []
    @Published var isLoading = false
    
    func loadHomeSections() async {
        isLoading = true
        do {
            let fetchedSections = try await APIService.shared.fetchHomeSections()
            sections = fetchedSections
        } catch {
            print("Error fetching sections: \(error)")
        }
        isLoading = false
    }
}
