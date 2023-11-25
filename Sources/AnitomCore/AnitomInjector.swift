//
//  AnitomInjector.swift
//  Anitom
//
//  Created by 孔维锐 on 11/25/23.
//

import Foundation
class AnitomInjector: ObservableObject{
    @Published var isOn: Bool = false
    @Published var isShaddowOn = false
    @Published var offsetX: CGFloat = 0
    @Published var offsetY: CGFloat = 0
    @Published var scale: CGFloat = 1
}

