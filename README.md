
# About
**Anitom**, aka *Animation Atom*, is an open-source library for animation effects based on SwiftUI. It aims to provide stunning advanced animation effects to developers with simple and understandable code, all built on Swift. 

Currently, the project is in its **early stages** and undergoing refinement of its content. Therefore, it is not yet ready to be integrated into your project. However, I will strive to develop and improve this animation library as soon as possible. Once the basic development is complete, I will release the first usable version. 

> As a college student, my understanding of Swift and SwiftUI may not be extensive, so I welcome any feedback or corrections from anyone.

# UI Elements

## ImageStack

**ImageStack**, by combining `.rotationEffect()` and `.rotation3DEffect()` effects, allows a list of images to display like a tile (yep, aka iMessage style). All you need to do is provide a list `images: [Image]`, orientation and a customizable frame size. Enabling 3D effect may cause frame drop on older devices.

<table>
  <thead>
    <tr>
      <th>Preview</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><img src="https://imgs.onespirit.fyi/i/2024/06/01/owyk38.gif" alt="image is loading..." style="max-width: 300px;"></td>
    </tr>
  </tbody>
</table>

```swift
@State var imgs = [Image("dog1"), Image("dog2"), Image("dog3"), Image("dog4")]
@State var orientation = AnitomOrientation.clockwise

ImageStack(
    images: $imgs, 
    imageSize: CGSize(width: 200.0, height: 300.0), 
    orientation: orientation, 
    advanced3DEffectEnabled: true
)

// Using default dragThreshold is recommended. You can also attach a closure to perform actions when an image is tapped.
```


## ReversibleCard

**ReversibleCard**, by combining `.scaleEffect()`, `.rotationEffect()` and `.rotation3DEffect()` effects, allows a view to appear as a reversible card. You can customize both `front` and `back` view, as well as the way the action triggers. The builtin background is Material, however, you should diasble it if target devices are lack of GPU performance.

<table>
  <thead>
    <tr>
      <th>Preview</th>
      <th>Good Example</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><img src="https://imgs.onespirit.fyi/i/2024/05/30/kdn0ue.gif" alt="image is loading... " style="max-width: 300px;"></td>
      <td><img src="https://imgs.onespirit.fyi/i/2024/05/30/kefbnd.gif" alt="image is loading... " style="max-width: 300px;"></td>
    </tr>
  </tbody>
</table>


### Usage

You can either use your customized flag or leave it empty, in which case a built-in flag will be activated.

```swift
ReversibleCard(orientation: .vertical, useBuiltinBackgrounds: true, tapToFlip: true){
    VStack{
        Text(".vertical")
            .font(.title)
    }
}back: {
    VStack{
        Text(".vertical")
            .font(.title)
    }
}

@State var isflipped: Bool = false
ReversibleCard(isFlipped: $isflipped, orientation: .vertical){
    VStack{
        Text("use external binding front")
            .font(.title)
    }
}back: {
    VStack{
        Text("use external binding back")
            .font(.title)
    }
}
Button("toggle"){
    isflipped.toggle()
    print("external controller:\(isflipped)")
}
```
### Restriction
Under this mode, only `.vertical`, `.horizontal`, and `.diagonal` of `AnitomOrientation` is allowed, otherwise your app crashes.

Please also make sure that the bounds of both sides are similiar, or the card behaves wierd. Use fixed `.frame(x: CGFloat, y: CGFloat)` in each card content will help.
# Effects

## Floating Recursive / OnHover

**Floating Recursive / OnHover**, by combining `.offset()` and `.shadow()` effects, allows a view to appear as if it's floating above other interfaces. It is particularly suitable for use in guide pages with large image splash. The `.scaledEffect()` effect is optional, but I highly recommend using it for that.

<img src="https://imgs.onespirit.fyi/i/2024/05/30/ka66fh.gif" alt="Floating " style="max-width: 300px;">


### Usage
```swift
@StateObject var inj = AnitomInjector( animation: {_ in Animation.easeInOut(duration: 1)})

// simple 
Image("swift")
    .onHoverFloating(
        inj: inj, 
        primary: AnitomMovement(ori: .up, dist: 20), 
        secondary: AnitomMovement(ori: .up, dist: 0)
    )
// full
Image("swift")
    .recursiveFloatingScaled(
        inj: inj, 
        primary: AnitomMovement(ori: .up, dist: 20), 
        secondary: AnitomMovement(ori: .up, dist: 0),
        nonstop: Bool = true, 
        duration: Double = 1, 
        dropShaddow: Bool = true, 
        scaleMargin: Double? = 0.02
    )
```

### Restriction
Under this mode, only `.up`, `.down`, `.left` and `.right` of `AnitomOrientation` is allowed, otherwise your app crashes.
