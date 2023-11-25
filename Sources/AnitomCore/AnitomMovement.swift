//
//  AnitomMovement.swift
//  Anitom
//
//  Created by 孔维锐 on 11/25/23.
//

import Foundation
struct AnitomMovement{
    let orientation: AnitomOrientation
    let distance: CGFloat
    
    init(ori orientation: AnitomOrientation, dist distance: CGFloat) {
        self.orientation = orientation
        self.distance = distance
    }
}
