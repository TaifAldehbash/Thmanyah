import SwiftUI

struct SearchView: View {
    @StateObject private var viewModel = SearchViewModel()
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            VStack (alignment: .leading) {
                searchBar
                
                if viewModel.isLoading {
                    ProgressView()
                        .padding()
                    Spacer()
                } else if viewModel.isEmpty {
                    Text("Nothing here yet — try a different keyword!")
                        .foregroundColor(.secondary)
                        .padding()
                    Spacer()
                } else {
                    ScrollView {
                        LazyVStack(spacing: 24) {
                            ForEach(viewModel.results) { section in
                                SectionView(section: section)
                            }
                        }
                        .padding(.vertical)
                    }
                }
            }
            .padding(.horizontal)
        }
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "chevron.backward")
                        .foregroundColor(.primary)
                }
            }
        }
    }
    
    private var searchBar: some View {
        TextField("Search for a podcast, episode, audiobook…", text: $viewModel.query)
            .padding(12)
            .background(Color("CardColor"))
            .cornerRadius(100)
            .onChange(of: viewModel.query, { oldValue, newValue in
                viewModel.onQueryChanged(newValue)
            })
    }
}
