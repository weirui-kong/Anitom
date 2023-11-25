//
//  RecursiveFloating.swift
//  Anitom
//
//  Created by 孔维锐 on 11/25/23.
//

import Foundation
import SwiftUI
extension View{
    public func recursiveFloating(inj injector: AnitomInjector, primary: AnitomMovement?, secondary: AnitomMovement?, nonstop: Bool = true, duration: Double = 1, dropShaddow: Bool = true, scaleMargin: Double? = 0.02) -> some View{
        
        return self
            .offset(x: injector.offsetX, y: injector.offsetY)
            .shadow(radius: injector.isShaddowOn ? 5 : 0, x: injector.isShaddowOn ? 5 : 0, y: injector.isShaddowOn ? 5 : 0)
            .scaleEffect(injector.scale)
            .onAppear{
                injector.isRecursiveOn = true
                injector.isShaddowOn = dropShaddow
                DispatchQueue.global().async {
                    var bool = true
                    while injector.isRecursiveOn{
                        DispatchQueue.main.async {
                            withAnimation(injector.animation(TimeInterval(duration))){
                                let pri = primary ?? AnitomMovement(ori: .up, dist: 20)
                                let sec = secondary ?? AnitomMovement(ori: .up, dist: 0)
                                
                                if bool{
                                    switch(pri.orientation){
                                    case .up: injector.offsetY = -pri.distance
                                    case .down: injector.offsetY = pri.distance
                                    case .left: injector.offsetX = -pri.distance
                                    case .right: injector.offsetX = pri.distance
                                    }
                                    injector.scale = 1 + (scaleMargin ?? 0)
                                }else{
                                    switch(sec.orientation){
                                    case .up: injector.offsetY = -sec.distance
                                    case .down: injector.offsetY = sec.distance
                                    case .left: injector.offsetX = -sec.distance
                                    case .right: injector.offsetX = sec.distance
                                    }
                                    injector.scale = 1 - (scaleMargin ?? 0)
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
                injector.isRecursiveOn = false
            }
    }
}
