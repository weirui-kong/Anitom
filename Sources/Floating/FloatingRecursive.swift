//
//  Floating Recursive.swift
//  Anitom
//
//  Created by 孔维锐 on 11/25/23.
//

import Foundation
import SwiftUI
extension View{
    func recursiveFloating(inj injector: AnitomInjector, primary: AnitomMovement = AnitomMovement(ori: .up, dist: 20), secondary: AnitomMovement = AnitomMovement(ori: .up, dist: 0), nonstop: Bool = true, duration: Double = 1, dropShaddow: Bool = true) -> some View{
        let body = recursiveFloatingScaled(inj: injector, primary: primary, secondary: secondary, nonstop: nonstop, duration: duration, dropShaddow: dropShaddow, scaleMargin: 0)
        return body
        
    }
    
    func recursiveFloatingScaled(inj injector: AnitomInjector, primary: AnitomMovement = AnitomMovement(ori: .up, dist: 20), secondary: AnitomMovement = AnitomMovement(ori: .up, dist: 0), nonstop: Bool = true, duration: Double = 1, dropShaddow: Bool = true, scaleMargin: Double = 0.02) -> some View{
        
        return self
            .offset(x: injector.offsetX, y: injector.offsetY)
            .shadow(radius: injector.isShaddowOn ? 5 : 0, x: injector.isShaddowOn ? 5 : 0, y: injector.isShaddowOn ? 5 : 0)
            .scaleEffect(injector.scale)
            .onAppear{
                injector.isOn = true
                injector.isShaddowOn = dropShaddow
                DispatchQueue.global().async {
                    var bool = true
                    while injector.isOn{
                        DispatchQueue.main.async {
                            withAnimation(.easeInOut(duration: TimeInterval(duration))){
                                if bool{
                                    switch(primary.orientation){
                                    case .up: injector.offsetY = -primary.distance
                                    case .down: injector.offsetY = primary.distance
                                    case .left: injector.offsetX = -primary.distance
                                    case .right: injector.offsetX = primary.distance
                                    }
                                    injector.scale = 1 + scaleMargin
                                }else{
                                    switch(secondary.orientation){
                                    case .up: injector.offsetY = -secondary.distance
                                    case .down: injector.offsetY = secondary.distance
                                    case .left: injector.offsetX = -secondary.distance
                                    case .right: injector.offsetX = secondary.distance
                                    }
                                    injector.scale = 1 - scaleMargin
                                }
                                if dropShaddow{injector.isShaddowOn.toggle()}
                            }
                        }
                        bool.toggle()
                       
                        usleep(useconds_t(duration * 1_000_000))
                    }
                }
            }
            .onDisappear{
                injector.isOn = false
            }
    }
}
