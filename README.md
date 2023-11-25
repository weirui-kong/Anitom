
# About
**Anitom**, aka *Animation Atom*, is an open-source library for animation effects based on SwiftUI. It aims to provide stunning advanced animation effects to developers with simple and understandable code, all built on Swift. 

Currently, the project is in its **early stages** and undergoing refinement of its content. Therefore, it is not yet ready to be integrated into your project. However, I will strive to develop and improve this animation library as soon as possible. Once the basic development is complete, I will release the first usable version. 

> As a college student, my understanding of Swift and SwiftUI may not be extensive, so I welcome any feedback or corrections from anyone.

# Effects

## Floating Recursive / OnHover

**Floating Recursive / OnHover**, by combining `.offset()` and `.shadow()` effects, allows a view to appear as if it's floating above other interfaces. It is particularly suitable for use in guide pages with large image splash. The `.scaledEffect()` effect is optional, but I highly recommend using it for that.

<img src="./README_SRC/floating.gif" alt="Floating " style="max-width: 300px;">

### Declaration
```swift
func onHoverFloating(
    inj injector: AnitomInjector, 
    primary: AnitomMovement = AnitomMovement(ori: .up, dist: 20), 
    secondary: AnitomMovement = AnitomMovement(ori: .up, dist: 0), 
    nonstop: Bool = true, 
    duration: Double = 0.5, 
    dropShaddow: Bool = true, 
    scaleMargin: Double? = 0.02
    ) -> some View

func recursiveFloating(
    inj injector: AnitomInjector, 
    primary: AnitomMovement = AnitomMovement(ori: .up, dist: 20), 
    secondary: AnitomMovement = AnitomMovement(ori: .up, dist: 0), 
    nonstop: Bool = true, 
    duration: Double = 1, 
    dropShaddow: Bool = true, 
    scaleMargin: Double? = 0.02
    ) -> some View

```
### Usage
```swift
@StateObject var inj = AnitomInjector( animation: {_ in Animation.easeInOut(duration: 1)})

Image("swift")
    .recursiveFloatingScaled(
        inj: inj, 
        primary: AnitomMovement(ori: .up, dist: 20), 
        secondary: AnitomMovement(ori: .up, dist: 0)
    )
```
