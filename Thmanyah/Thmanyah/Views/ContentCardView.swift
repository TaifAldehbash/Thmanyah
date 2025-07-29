import SwiftUI

struct ContentCardView: View {
    let item: ContentItem
    let type: SectionLayout
    
    var body: some View {
        switch type {
            case .twoLinesGrid:
                HStack(alignment: .top, spacing: 12) {
                    //            Image
                    AsyncImage(url: URL(string: item.avatar_url)) { image in
                        image
                            .resizable()
                            .scaledToFill()
                    } placeholder: {
                        Color.gray.opacity(0.2)
                    }
                    .frame(width: 96, height: 96)
                    .clipped()
                    .cornerRadius(20)
                    .shadow(color: .black.opacity(0.2), radius: 2, x: 0, y: 0)
                    VStack (alignment: .leading){
                        //            Title
                        Text(item.name)
                            .font(Font.custom("IBMPlexMono-Regular", size: 16))
                            .padding(EdgeInsets(top: 12, leading: 0, bottom: 0, trailing: 0))
                            .foregroundColor(Color("TextColor"))
                            .frame(maxWidth: .infinity, alignment: .topLeading)
                            .lineLimit(2)
                        Spacer()
                        //                    Duration
                        HStack(alignment: .center, spacing: 8) {
                            Text(item.formattedDuration ?? "0 h 0 min")
                                .font(Font.custom("IBMPlexMono-Regular", size: 12))
                                .foregroundColor(Color("TextColor"))
                            Image(systemName: "play.fill")
                                .resizable()
                                .frame(width: 12, height: 12)
                        }
                        .padding(EdgeInsets(top: 8, leading: 12, bottom: 8, trailing: 12))
                        .background(Color("CardColor"))
                        .cornerRadius(100)
                    }
                    
                }
                .frame(width: 400, height: 96)
                
            case .queue:
                HStack(alignment: .center) {
                    //            Image
                    AsyncImage(url: URL(string: item.avatar_url)) { image in
                        image
                            .resizable()
                            .scaledToFill()
                    } placeholder: {
                        Color.gray.opacity(0.2)
                    }
                    .frame(width: 80, height: 80)
                    .clipped()
                    .cornerRadius(12)
                    .shadow(color: .black.opacity(0.2), radius: 2, x: 0, y: 0)
                    //            Title
                    VStack (alignment: .leading){
                        Text(item.name)
                            .font(Font.custom("IBMPlexMono-SemiBold", size: 16))
                            .foregroundColor(Color("TextColor"))
                            .frame(maxWidth: .infinity, alignment: .topLeading)
                            .lineLimit(2)
                        
                        HStack (alignment: .center){
                            Text(item.formattedDuration!)
                                .font(Font.custom("IBMPlexMono-Regular", size: 16))
                                .foregroundColor(Color("TextColor"))
                                .frame(maxWidth: .infinity, alignment: .topLeading)
                                .lineLimit(2)
                            Image(systemName: "play.circle.fill")
                                .resizable()
                                .frame(width: 32, height: 32)
                        }
                    }.padding(.vertical, 12)
                }
                .padding(12)
                .frame(width: 360, height: 100, alignment: .leading)
                .background(Color("CardColor"))
                .cornerRadius(20)
                
            case .bigSquare:
                VStack(alignment: .leading, spacing: 8) {
                    //            Image
                    AsyncImage(url: URL(string: item.avatar_url)) { image in
                        image
                            .resizable()
                            .scaledToFill()
                    } placeholder: {
                        Color.gray.opacity(0.2)
                    }
                    .frame(maxWidth: .infinity, maxHeight: 180)
                    .clipped()
                    .cornerRadius(12)
                    .shadow(color: .black.opacity(0.2), radius: 2, x: 0, y: 0)
                    
                    //            Title
                    Text(item.name)
                        .font(Font.custom("IBMPlexMono-Bold", size: 18))
                        .foregroundColor(Color("TextColor"))
                        .frame(maxWidth: .infinity, alignment: .topLeading)
                        .lineLimit(2)
                }
                .frame(width: 264, height: 230)
                
                
                
                
            case .square:
                VStack(alignment: .leading, spacing: 8) {
                    //            Image
                    AsyncImage(url: URL(string: item.avatar_url)) { image in
                        image
                            .resizable()
                            .scaledToFill()
                    } placeholder: {
                        Color.gray.opacity(0.2)
                    }
                    .frame(width: 160, height: 160)
                    .clipped()
                    .cornerRadius(20)
                    .shadow(color: .black.opacity(0.2), radius: 2, x: 0, y: 0)
                    //            Title
                    Text(item.name)
                        .font(Font.custom("IBMPlexMono-Medium", size: 18))
                        .foregroundColor(Color("TextColor"))
                        .frame(maxWidth: .infinity, minHeight: 50, alignment: .topLeading)
                        .lineLimit(2)
                    
                    //                    Duration
                    if(item.duration != nil || item.formattedDuration != nil){
                        HStack(alignment: .center, spacing: 8) {
                            Text(item.formattedDuration!)
                                .font(Font.custom("IBMPlexMono-Regular", size: 12))
                                .foregroundColor(Color("TextColor"))
                            Image(systemName: "play.fill")
                                .resizable()
                                .frame(width: 12, height: 12)
                        }
                        .padding(EdgeInsets(top: 8, leading: 12, bottom: 8, trailing: 12))
                        .background(Color("CardColor"))
                        .cornerRadius(100)
                    }
                    
                }
                .frame(width: 160)
        }
    }
}
