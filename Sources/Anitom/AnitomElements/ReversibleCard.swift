//
//  ReversibleCard.swift
//  Anitom
//
//  Created by 孔维锐 on 12/19/23.
//

import SwiftUI

import SwiftUI

struct ReversibleCard: View {
    
    // MARK: - Initialization
    
    /// Initializes a reversible card with optional external binding, orientation, and other parameters.
    /// - Parameters:
    ///   - externalBool: Optional binding for flipping the card externally.
    ///   - orientation: The orientation of the reversible card.
    ///   - useBuiltinBackgrounds: A boolean indicating whether to use built-in background styling.
    ///   - tapToFlip: A boolean indicating whether tapping on the card flips it.
    ///   - front: A closure returning the content of the front side of the card.
    ///   - back: A closure returning the content of the back side of the card.
    init(isFlipped externalBool: Binding<Bool>? = nil, orientation: AnitomOrientation, useBuiltinBackgrounds: Bool = true, tapToFlip: Bool = true, front: @escaping () -> some View, back: @escaping () -> some View) {
        // This line assigns the externalBool parameter to the externalBool property of the ReversibleCard.
        // This property represents an optional external binding that allows flipping the card externally.
        // If an external binding is provided during initialization, the card will synchronize its flipped state with the value of this external boolean.
        self.externalBool = externalBool

        // This line initializes the _trigger property with the value of externalBool if it is not nil.
        // If externalBool is nil, it uses a constant binding with a default value of false.
        // The `_trigger` property is a binding to a boolean value that triggers changes in the card.
        // If externalBool is provided, it will be used to update the isFlipped state.
        // If not provided, _trigger serves as a default constant binding.
        // This approach allows the program to decide whether the flipped state should be stored in an internal `@State` variable or an external `@Binding` variable.
        // The use of a constant binding in case of nil externalBool ensures that the code using _trigger won't break even if externalBool is not provided.
        // The `onChange` modifier in the code listens for changes in _trigger and triggers the flipping animation when it detects a change.
        _trigger = externalBool ?? .constant(false)

        self.front = AnyView(front())
        self.back = AnyView(back())
        self.tapToFlip = tapToFlip
        
        // Configure flip animation based on the specified orientation.
        switch orientation {
        case .vertical:
            flipConfig = (1, -1, 0, 1, 0, 0)
        case .horizontal:
            flipConfig = (-1, 1, 0, 0, 1, 0)
        case .diagonal:
            flipConfig = (-1, 1, 270, 1, 1, 0)
        default:
            fatalError("Orientation \(orientation) is not available in this mode! Please refer to the documentation.")
        }
    }
    
    // MARK: - Properties
    
    // A boolean indicating whether the card is currently flipped or not.
    @State private var isFlipped = false

    // An optional external binding that allows flipping the card externally.
    // If provided, the card will sync its flipped state with the externalBool.
    // This enables external control of the card's flip state.
    @State private var externalBool: Binding<Bool>?

    // A binding to a boolean value that triggers changes in the card.
    // This binding is typically connected to an external source that signals when the card should update its content or state.
    // For example, when the trigger value changes, the card might react by flipping or updating its content.
    @Binding private var trigger: Bool
    
    var useBuiltinBackgrounds = true
    var tapToFlip = true
    private var flipConfig: (CGFloat, CGFloat, CGFloat, CGFloat, CGFloat, CGFloat)
    var front: AnyView
    var back: AnyView
    
    // MARK: - Body
    
    var body: some View {
        Group {
            ZStack {
                if isFlipped {
                    back.scaleEffect(isFlipped ? 1 : 0)
                } else {
                    front.scaleEffect(isFlipped ? 0 : 1)
                }
            }
            .padding(useBuiltinBackgrounds ? 10 : 0)
            .background {
                if useBuiltinBackgrounds {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.ultraThinMaterial)
                }
            }
            .scaleEffect(x: isFlipped ? flipConfig.0 : 1)
            .scaleEffect(y: isFlipped ? flipConfig.1 : 1)
        }
        .rotationEffect(Angle(degrees: isFlipped ? flipConfig.2 : 0))
        .rotation3DEffect(.degrees(isFlipped ? 180 : 0), axis: (x: flipConfig.3, y: flipConfig.4, z: flipConfig.5))
        .onChange(of: trigger) { newValue in
            withAnimation(.spring) {
                isFlipped = externalBool!.wrappedValue
            }
        }
        .onTapGesture {
            if tapToFlip {
                withAnimation(.spring) {
                    if let eb = externalBool {
                        externalBool!.wrappedValue.toggle()
                    } else {
                        isFlipped.toggle()
                    }
                }
            }
        }
    }
    
    // MARK: - Helper Method
    
    /// Creates an empty view.
    /// - Returns: An empty view.
    func makeEmptyView() -> some View {
        EmptyView()
    }
}
