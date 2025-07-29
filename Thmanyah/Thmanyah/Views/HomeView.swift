import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    
    var body: some View {
        NavigationView {
            
            ScrollView {
                LazyVStack(spacing: 24) {
                    HStack{
                        Image("ENLogo")
                            .resizable()
                            .frame(width: 160, height: 32)
                        Spacer()
                        NavigationLink(destination: SearchView()) {
                            Image(systemName: "magnifyingglass")
                                .resizable()
                                .frame(width: 24, height: 24)
                        }.foregroundStyle(Color("TextColor"))
                    }.padding(.horizontal)
                    ForEach(viewModel.sections.indices, id: \.self) { index in
                        SectionView(section: viewModel.sections[index])
                            .onAppear {
                                if (index == viewModel.sections.count - 1){
                                    Task {
                                        await viewModel.loadMoreSectionsIfNeeded(currentItem: viewModel.sections[index])
                                    }
                                }
                            }
                    }
                }
                .padding(.vertical)
            }
            .task {
                await viewModel.loadInitialSections()
            }
        }
        .background(Color("BackgroundColor"))
        .ignoresSafeArea()
    }
}
