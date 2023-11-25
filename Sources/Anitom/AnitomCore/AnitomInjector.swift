//
//  AnitomInjector.swift
//  Anitom
//
//  Created by 孔维锐 on 11/25/23.
//

import Foundation
import SwiftUI
public class AnitomInjector: ObservableObject{
    @Published public var isRecursiveOn: Bool = false
    @Published public var isShaddowOn: Bool = false
    @Published public var offsetX: CGFloat = 0
    @Published public var offsetY: CGFloat = 0
    @Published public var scale: CGFloat = 1
    @Published public var animation: (TimeInterval) -> Animation = { t in
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
