//
//  SplashView.swift
//  Thmanyah
//
//  Created by Taif Al.qahtani on 29/07/2025.
//

import SwiftUI

struct SplashView: View {
    
    @State var splashAnimation = false
    
    var body: some View {
        ZStack{
            
            HomeView()
                .opacity(splashAnimation ? 1 : 0)
            
            Color("RedColor")
                .mask(
                    Rectangle()
                        .overlay(
                            Image("Logo")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 140, height: 160)
                                .scaleEffect(splashAnimation ? 200 : 1)
                                .blendMode(.destinationOut)
                        )
                )
        }.ignoresSafeArea()
            .preferredColorScheme(splashAnimation ? nil : .light)
            .onAppear{
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.4){
                    withAnimation(.easeInOut(duration: 0.4)) {
                        splashAnimation.toggle()
                    }
                }
            }
    }
}

#Preview {
    SplashView()
}

struct SplashLogo: Shape{
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.move(to: CGPoint(x: 0.48005*width, y: 0.00405*height))
        path.addCurve(to: CGPoint(x: 0.46721*width, y: 0.03929*height), control1: CGPoint(x: 0.47924*width, y: 0.005*height), control2: CGPoint(x: 0.4735*width, y: 0.02095*height))
        path.addCurve(to: CGPoint(x: 0.37842*width, y: 0.23786*height), control1: CGPoint(x: 0.44317*width, y: 0.10929*height), control2: CGPoint(x: 0.41038*width, y: 0.18262*height))
        path.addCurve(to: CGPoint(x: 0.02104*width, y: 0.56786*height), control1: CGPoint(x: 0.29809*width, y: 0.37762*height), control2: CGPoint(x: 0.17924*width, y: 0.48738*height))
        path.addCurve(to: CGPoint(x: 0.00328*width, y: 0.58*height), control1: CGPoint(x: 0.01093*width, y: 0.5731*height), control2: CGPoint(x: 0.00301*width, y: 0.57857*height))
        path.addCurve(to: CGPoint(x: 0.12432*width, y: 0.79024*height), control1: CGPoint(x: 0.00383*width, y: 0.58167*height), control2: CGPoint(x: 0.0582*width, y: 0.67619*height))
        path.addLine(to: CGPoint(x: 0.24454*width, y: 0.99738*height))
        path.addLine(to: CGPoint(x: 0.25328*width, y: 0.99762*height))
        path.addCurve(to: CGPoint(x: 0.28224*width, y: 0.97429*height), control1: CGPoint(x: 0.2612*width, y: 0.99762*height), control2: CGPoint(x: 0.26393*width, y: 0.99548*height))
        path.addCurve(to: CGPoint(x: 0.48361*width, y: 0.55714*height), control1: CGPoint(x: 0.38934*width, y: 0.85095*height), control2: CGPoint(x: 0.45328*width, y: 0.71809*height))
        path.addCurve(to: CGPoint(x: 0.48907*width, y: 0.52548*height), control1: CGPoint(x: 0.48661*width, y: 0.54071*height), control2: CGPoint(x: 0.48907*width, y: 0.52667*height))
        path.addCurve(to: CGPoint(x: 0.49973*width, y: 0.52381*height), control1: CGPoint(x: 0.48907*width, y: 0.52452*height), control2: CGPoint(x: 0.49372*width, y: 0.52381*height))
        path.addLine(to: CGPoint(x: 0.51011*width, y: 0.52381*height))
        path.addLine(to: CGPoint(x: 0.51202*width, y: 0.53619*height))
        path.addCurve(to: CGPoint(x: 0.52076*width, y: 0.58095*height), control1: CGPoint(x: 0.51311*width, y: 0.5431*height), control2: CGPoint(x: 0.51694*width, y: 0.56333*height))
        path.addCurve(to: CGPoint(x: 0.7112*width, y: 0.96714*height), control1: CGPoint(x: 0.55137*width, y: 0.72643*height), control2: CGPoint(x: 0.61448*width, y: 0.85452*height))
        path.addCurve(to: CGPoint(x: 0.7459*width, y: 0.99714*height), control1: CGPoint(x: 0.73415*width, y: 0.99405*height), control2: CGPoint(x: 0.73716*width, y: 0.99643*height))
        path.addLine(to: CGPoint(x: 0.75546*width, y: 0.99762*height))
        path.addLine(to: CGPoint(x: 0.87568*width, y: 0.79024*height))
        path.addCurve(to: CGPoint(x: 0.99672*width, y: 0.58024*height), control1: CGPoint(x: 0.9418*width, y: 0.67643*height), control2: CGPoint(x: 0.99617*width, y: 0.58167*height))
        path.addCurve(to: CGPoint(x: 0.97896*width, y: 0.56786*height), control1: CGPoint(x: 0.99699*width, y: 0.57857*height), control2: CGPoint(x: 0.98907*width, y: 0.5731*height))
        path.addCurve(to: CGPoint(x: 0.77732*width, y: 0.43071*height), control1: CGPoint(x: 0.90328*width, y: 0.52929*height), control2: CGPoint(x: 0.83689*width, y: 0.48429*height))
        path.addCurve(to: CGPoint(x: 0.54672*width, y: 0.07619*height), control1: CGPoint(x: 0.67486*width, y: 0.33857*height), control2: CGPoint(x: 0.60546*width, y: 0.23214*height))
        path.addCurve(to: CGPoint(x: 0.52295*width, y: 0.01191*height), control1: CGPoint(x: 0.53497*width, y: 0.04548*height), control2: CGPoint(x: 0.52432*width, y: 0.01643*height))
        path.addLine(to: CGPoint(x: 0.52022*width, y: 0.00357*height))
        path.addLine(to: CGPoint(x: 0.50082*width, y: 0.00286*height))
        path.addCurve(to: CGPoint(x: 0.48005*width, y: 0.00405*height), control1: CGPoint(x: 0.49016*width, y: 0.00238*height), control2: CGPoint(x: 0.48087*width, y: 0.0031*height))
        path.closeSubpath()
        return path
    }
}
