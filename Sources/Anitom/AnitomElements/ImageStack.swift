//
//  ImageStack.swift
//  Anitom
//
//  Created by 孔维锐 on 5/29/24.
//

import Foundation
import SwiftUI

/// A view that displays a stack of images with drag and rotation gestures.
struct ImageStack: View {
    /// An array of images to be displayed in the stack.
    @Binding var images: [Image]
    
    /// The size of each image in the stack.
    var imageSize = CGSize(width: 200, height: 300)
    
    /// The ratio used to calculate the corner radius of the images.
    let cornerRadiusRatio = 0.1
    
    /// The corner radius of the images.
    var cornerRadius: CGFloat {
        return self.cornerRadiusRatio * min(self.imageSize.width, self.imageSize.height)
    }
    
    /// The orientation of the image stack.
    var orientation = AnitomOrientation.clockwise
    
    /// The angle of rotation for each image in the stack.
    let rotationAngleUnit = Angle(degrees: 10)
    
    /// The threshold value for dragging. If the user drags beyond this value, the image will move to the end of the stack.
    var dragThreshold: CGFloat = 50
    
    /// The offset for dragging the current image.
    @State private var dragOffset = CGSize.zero
    
    /// The rotation angle for dragging the current image.
    @State private var dragRotation: Angle = .zero
    
    /// The offset for the current index of the image stack.
    @State private var currentIndexOffset = 0
    
    /// Indicates if the advanced 3D effect is enabled.
    var advanced3DEffectEnabled = true
    
    /// Closure to be called when an image is tapped
    var onImageTap: ((Image) -> Void)?
    
    var body: some View {
        ZStack {
            ForEach(0..<images.count, id: \.self) { i in
                let io = abs(i + currentIndexOffset) % images.count
                imageContainer(image: images[i])
                    .rotationEffect(
                        (rotationAngleUnit * Double(io * (orientation == .clockwise ? 1 : -1))) + (io == 0 ? dragRotation : .zero),
                        anchor: orientation == .clockwise ? .bottomTrailing : .bottomLeading
                    )
                    .rotation3DEffect(advanced3DEffectEnabled ? dragRotation * 0.2 : .zero, axis: (1, 1, 0))
                    .shadow(radius: 5)
                    .opacity(1.5 - Double(io) * 0.45)
                    .blur(radius: CGFloat(0.8 * Double(io)))
                    .zIndex(Double(-io))
                    .offset(io == 0 ? dragOffset : .zero)
                    .onTapGesture {
                        onImageTap?(images[i])
                    }
                    .gesture(
                        io == 0 ? DragGesture()
                            .onChanged { value in
                                withAnimation(.spring()) {
                                    dragOffset = applyDragOffsetThresholdMapping(to: value.translation)
                                    dragRotation = applyDragRotationThresholdMapping(to: value.translation)
                                }
                            }
                            .onEnded { value in
                                withAnimation() {
                                    if abs(value.translation.width) > dragThreshold || abs(value.translation.height) > dragThreshold {
                                        currentIndexOffset = currentIndexOffset - 1 <= 0 ? currentIndexOffset - 1 + images.count : currentIndexOffset - 1
                                    }
                                    dragOffset = .zero
                                    dragRotation = .zero
                                }
                            }
                        : nil
                    )
            }
        }
    }
    
    /// Creates a container view for an image with specified properties.
    /// - Parameter image: The image to be displayed.
    /// - Returns: A view that displays the image with the specified size and corner radius.
    private func imageContainer(image: Image) -> some View {
        return image
            .resizable()
            .scaledToFill()
            .frame(width: imageSize.width, height: imageSize.height)
            .clipped()
            .cornerRadius(cornerRadius)
    }
    
    /// Applies threshold mapping to the drag offset to limit the maximum translation distance.
    /// - Parameter translation: The current drag translation.
    /// - Returns: The adjusted drag offset.
    private func applyDragOffsetThresholdMapping(to translation: CGSize) -> CGSize {
        let maxTranslation: CGFloat = dragThreshold * 1.15 // Maximum allowed drag distance
        let factor: CGFloat = 0.1 // Scaling factor for reducing the offset
        
        // Calculate the total drag distance
        let distance = sqrt(translation.width * translation.width + translation.height * translation.height)
        
        // If the distance exceeds the maximum, reduce the offset accordingly
        if distance > maxTranslation {
            let scale = maxTranslation + (distance - maxTranslation) * factor
            let adjustedWidth = (translation.width / distance) * scale
            let adjustedHeight = (translation.height / distance) * scale
            return CGSize(width: adjustedWidth, height: adjustedHeight)
        } else {
            return translation
        }
    }
    
    /// Applies threshold mapping to the drag rotation to limit the maximum rotation angle.
    /// - Parameter translation: The current drag translation.
    /// - Returns: The adjusted drag rotation angle.
    private func applyDragRotationThresholdMapping(to translation: CGSize) -> Angle {
        let maxTranslation: CGFloat = dragThreshold * 1.1 // Maximum allowed drag distance
        let factor: CGFloat = 0.1 // Scaling factor for reducing the rotation
        let maxRotation: Double = 15.0 // Maximum allowed rotation angle
        
        // Calculate the total drag distance
        let distance = sqrt(translation.width * translation.width + translation.height * translation.height)
        
        // If the distance exceeds the maximum, reduce the rotation angle accordingly
        if distance > maxTranslation {
            let scale = maxTranslation + (distance - maxTranslation) * factor
            let adjustedWidth = (translation.width / distance) * scale
            let rotationDegrees = (adjustedWidth) * maxRotation / maxTranslation
            return Angle(degrees: Double(rotationDegrees))
        } else {
            let rotationDegrees = (translation.width) * maxRotation / maxTranslation
            return Angle(degrees: Double(rotationDegrees))
        }
    }
}

extension Angle {
    /// Multiplies an angle by a scalar value.
    /// - Parameters:
    ///   - left: The angle to be multiplied.
    ///   - right: The scalar value.
    /// - Returns: The resulting angle after multiplication.
    static func *(left: Angle, right: Double) -> Angle {
        return Angle(degrees: left.degrees * right)
    }
    
    /// Adds two angles together.
    /// - Parameters:
    ///   - left: The first angle.
    ///   - right: The second angle.
    /// - Returns: The resulting angle after addition.
    static func +(left: Angle, right: Angle) -> Angle {
        return Angle(degrees: left.degrees + right.degrees)
    }
}
