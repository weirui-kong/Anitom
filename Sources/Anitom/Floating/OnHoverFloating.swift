//
//  RecursiveFloating.swift
//  Anitom
//
//  Created by 孔维锐 on 11/25/23.
//

import Foundation
import SwiftUI
extension View{
    func onHoverFloating(inj injector: AnitomInjector, primary: AnitomMovement = AnitomMovement(ori: .up, dist: 20), secondary: AnitomMovement = AnitomMovement(ori: .up, dist: 0), duration: Double = 0.5, dropShaddow: Bool = true, scaleMargin: Double? = 0.02) -> some View{
        
        return self
            .offset(x: injector.offsetX, y: injector.offsetY)
            .shadow(radius: injector.isShaddowOn ? 5 : 0, x: injector.isShaddowOn ? 5 : 0, y: injector.isShaddowOn ? 5 : 0)
            .scaleEffect(injector.scale)
            .onHover{hover in
                withAnimation(injector.animation(TimeInterval(duration))){
                    injector.isShaddowOn = dropShaddow && hover
                    if hover{
                        switch(primary.orientation){
                        case .up: injector.offsetY = -primary.distance
                        case .down: injector.offsetY = primary.distance
                        case .left: injector.offsetX = -primary.distance
                        case .right: injector.offsetX = primary.distance
                        default:
                            fatalError("Orientation \(primary.orientation) is not aviliable is this mode! Please refer to the documentations.")
                        }
                        injector.scale = 1 + (scaleMargin ?? 0)
                    }else{
                        switch(secondary.orientation){
                        case .up: injector.offsetY = -secondary.distance
                        case .down: injector.offsetY = secondary.distance
                        case .left: injector.offsetX = -secondary.distance
                        case .right: injector.offsetX = secondary.distance
                        default:
                            fatalError("Orientation \(secondary.orientation) is not aviliable is this mode! Please refer to the documentations.")
                        }
                        injector.scale = 1 - (scaleMargin ?? 0)
                    }
                    
                }
            }
                        
 
    }
}
