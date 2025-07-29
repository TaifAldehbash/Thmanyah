import SwiftUI

struct SectionView: View {
    let section: HomeSection
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(section.name)
                .font(Font.custom("IBMPlexMono-SemiBold", size: 20))
                .padding(.horizontal)
            
            sectionBody
        }
    }
    
    @ViewBuilder
    private var sectionBody: some View {
        switch section.type {
            case .square:
                ScrollView(.horizontal, showsIndicators: false){
                    LazyHStack(spacing: 16) {
                        ForEach(section.content.indices, id: \.self) { index in
                            ContentCardView(item: section.content[index], type: section.type)
                        }
                    }
                    .frame(alignment: .leading)
                    .padding(.horizontal)
                }
                
            case .twoLinesGrid:
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack(spacing: 16) {
                        ForEach(Array(stride(from: 0, to: section.content.count, by: 2)), id: \.self) { index in
                            LazyVStack(spacing: 16) {
                                ContentCardView(item: section.content[index], type: section.type)
                                
                                if index + 1 < section.content.count {
                                    ContentCardView(item: section.content[index + 1], type: section.type)
                                }
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                
            case .bigSquare:
                ScrollView(.horizontal, showsIndicators: false){
                    LazyHStack(spacing: 16){
                        ForEach(section.content.indices, id: \.self) { index in
                            ContentCardView(item: section.content[index], type: section.type)
                        }
                    }
                    .padding(.horizontal)
                }
                
            case .queue:
                ScrollView(.horizontal, showsIndicators: false){
                    LazyHStack(spacing: 16){
                        ForEach(section.content.indices, id: \.self) { index in
                            ContentCardView(item: section.content[index], type: section.type)
                        }
                    }
                    .padding(.horizontal)
                }
        }
    }
}
