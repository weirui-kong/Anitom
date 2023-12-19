//
//  ReversibleCard.swift
//  Anitom
//
//  Created by 孔维锐 on 12/19/23.
//

import SwiftUI

struct ReversibleCard: View {
    
    init(orientation: AnitomOrientation, useBuiltinBackgrounds: Bool = true, tapToFlip: Bool = true, front: @escaping () -> some View, back: @escaping () -> some View) {
        self.front = AnyView(front())
        self.back = AnyView(back())
        self.tapToFlip = tapToFlip
        switch(orientation){
        case .vertical:
            flipConfig = (1, -1, 0, 1, 0, 0)
        case .horizontal:
            flipConfig = (-1, 1, 0, 0, 1, 0)
        case .diagonal:
            flipConfig = (-1, 1, 270, 1, 1, 0)
        default:
            fatalError("Orientation \(orientation) is not aviliable is this mode! Please refer to the documentations.")
        }
    }
    
    @State var isFlipped = false
    var useBuiltinBackgrounds = true
    var tapToFlip = true
    private var flipConfig: (CGFloat, CGFloat, CGFloat, CGFloat, CGFloat, CGFloat)
    var front: AnyView
    var back: AnyView
    var body: some View {
        Group{
            ZStack{
                if isFlipped{
                    back.scaleEffect(isFlipped ? 1 : 0)
                }else{
                    front.scaleEffect(isFlipped ? 0 : 1)
                }
            }
            .padding(useBuiltinBackgrounds ? 10 : 0)
            .background{
                if useBuiltinBackgrounds{
                    RoundedRectangle(cornerRadius: 10)
                        //.shadow(radius: 3, x: 2, y: 2)
                        .fill(.ultraThinMaterial)
                }
            }
            .scaleEffect(x: isFlipped ? flipConfig.0 : 1)
            .scaleEffect(y: isFlipped ? flipConfig.1 : 1)
        }
        .rotationEffect(Angle(degrees: isFlipped ? flipConfig.2 : 0))
        .rotation3DEffect(.degrees(isFlipped ? 180 : 0), axis: (x: flipConfig.3, y: flipConfig.4, z: flipConfig.5))
        .onTapGesture {
            if tapToFlip{
                withAnimation(.spring){
                    isFlipped.toggle()
                }
                
            }
        }
    }
    
    func makeEmptyView() -> some View{
        EmptyView()
    }
}

#Preview {
    HStack(spacing: 30){
        ReversibleCard(orientation: .vertical){
            VStack{
                Text(".vertical")
                    .font(.title)
            }
        }back: {
            VStack{
                Text(".vertical")
                    .font(.title)
            }
        }
        ReversibleCard(orientation: .horizontal){
            VStack{
                Text(".horizontal")
                    .font(.title)
            }
        }back: {
            VStack{
                Text(".horizontal")
                    .font(.title)
            }
        }
        ReversibleCard(orientation: .diagonal){
            VStack{
                Text(".diagonal")
                    .font(.title)
            }
        }back: {
            VStack{
                Text(".diagonal")
                    .font(.title)
            }
        }
    }
}
