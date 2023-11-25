//
//  AnitomInjector.swift
//  Anitom
//
//  Created by 孔维锐 on 11/25/23.
//

import Foundation
import SwiftUI
class AnitomInjector: ObservableObject{
    @Published var isRecursiveOn: Bool = false
    @Published var isShaddowOn: Bool = false
    @Published var offsetX: CGFloat = 0
    @Published var offsetY: CGFloat = 0
    @Published var scale: CGFloat = 1
    @Published var animation: (TimeInterval) -> Animation = { t in
        Animation.spring(duration: t)
    }
    
    init(isRecursiveOn: Bool = false, isShaddowOn: Bool = false, offsetX: CGFloat = 0, offsetY: CGFloat = 0, scale: CGFloat = 1, animation: @escaping (TimeInterval) -> Animation = { t in Animation.spring(duration: t)}) {
        self.isRecursiveOn = isRecursiveOn
        self.isShaddowOn = isShaddowOn
        self.offsetX = offsetX
        self.offsetY = offsetY
        self.scale = scale
        self.animation = animation
    }
}
