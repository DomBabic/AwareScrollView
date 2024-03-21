<h1 align="center">AwareScrollView</h1>

<p align="center">
  <a href="https://developer.apple.com/ios/"><img alt="iOS 14.0+" src="https://img.shields.io/badge/ios-14.0-orange.svg?style=flat"></a>
  <a href="https://developer.apple.com/macos/"><img alt="MacOS 11.0+" src="https://img.shields.io/badge/macos-11.0-blue.svg?style=flat"></a>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/License-MIT-yellow.svg"/>
</p>

## What is `AwareScrollView`?

*SwiftUI* component used to easily manage content scrollability based on its intrinsic content size. 

It is especially useful for Apps that support [Dynamic Type](https://developer.apple.com/documentation/uikit/uifont/scaling_fonts_automatically/),
allowing you to automatically support scrolling for content that would normally not exceed *View*'s size. Same can be applied for devices with smaller screen size (looking at you, iPhone SE :eyes:).
If something would fit in the *View* of one device, it might exceed *View* size on the other.

This is where `AwareScrollView` shines! Instead of writing code for such exceptions, you can use `AwareScrollView` to automatically handle everything for you.

## How does it work?

Content that could potentially be scrolled is wrapped in a *ScrollView* which observes changes to its size. If content's size exceeds the size of *ScrollView*, 
scrolling is enabled in the direction of the *axes* provided at the component init.

Should the content size change at any time, component will automatically adjust to reflect this change.

<video src="./Resources/AwareScrollView.mov" width="240" height="320" controls></video>

## Installation

`AwareScrollView` is a package distributed via **Swift Package Manager**. To add it to the project follow the steps below:
- right click your project in **Xcode** navigator and select `Add Package Dependencies...` dialog option,
- on the presented popup click on the search bar in the top right corner and paste the below URL:
```
https://github.com/DomBabic/AwareScrollView
```
- choose `awarescrollview` from the list,
- select the project to add the package to via `Add to Project` dropdown menu and tap on `Add Package` button.

With the final step package is added to the project and ready to be used.

## Usage

To use `AwareScrollView`, first you will need to import the package:
```swift
import AwareScrollView
```

In your *SwiftUI* *View*, add `AwareScrollView` as a parent of some content *View*, similar to the example below.

```swift
var body: some View {
  AwareScrollView(viewModel: .init(axes: .vertical, showsIndicators: false) {
    someContent
  }
}

var someContent: some View {
  ...
}
```

> Note: `AwareScrollView` does not need to be the top level *View*, it can be nested in any other *View*.

By default, `AwareScrollView` uses `vertical` axis with scrolling indicator displayed. You can change this by providing the parameters of your choosing at init.
You can provide one or more scrolling axes at init. Component supports scrolling for `horizontal` and `vertical` axis, as well as combination of both axes.
You can choose to show or hide scrolling indicators by adding `showsIndicators` parameter at init.
