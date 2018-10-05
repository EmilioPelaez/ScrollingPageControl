# ScrollingPageControl

![](https://media.giphy.com/media/XZMQhuKAtfxf6NffKj/giphy.gif)

ScrollingPageControl is a custom page control inspired by Instagram's page control.

By default it shows up to seven dots, with dots farther from the center dot being smaller, and scrolls the dots as the user changes pages, always keeping the highlighted dot within the central dots.

The maximum number of dots, as well as the number of central dots, can be customized, as long as the values are an odd number.

Other customizable values are the color of the selected and highlighted dots, the size of the dots, and the space between the dots.

### Usage

To use the `ScrollingPageControl`, add it to your view hierarchy using Interface Builder or with code, it's recommended that you don't set width and height constraints, since the control can size itself. If you're using Interface Builder you can set a placeholder for `Intrinsc Content Size`.

The easiest way to set it up is to use a `UIScrollView` with `isPagingEnabled` set to `true`. Set `pages` to the number of pages in your scroll view, and then implement this method of `UIScrollViewDelegate` like this:

```swift
func scrollViewDidScroll(_ scrollView: UIScrollView) {
	let page = round(scrollView.contentOffset.x / scrollView.frame.width)
	pageControl.selectedPage = Int(page)
}
```

Make sure you set your object as the `delegate` of your scroll view.

### Custom dot

The control uses a `UIView` for each dot. By default, this view will be a simple circular view, but you can provide your own views by conforming to the `ScrollingPageControlDelegate` protocol and implementing `func viewForDot(at index: Int) -> UIView?`. If that function returns `nil`, the default circle dot will be used.

You can use that method to return an `UIImageView`, or a `UIView` subclass that draws a specific shape.

Dot views have to use the  `tintColor` property to tint their content, and update on `tintColorDidChange()`.

If you're using a `UIImageView`, you can simply use the image as a template like this `image.withRenderingMode(.alwaysTemplate)`. Then the `UIImage` will be tinted using the `tintColor` property of `UIImageView`.

For a working example, follow the "Example" instructions below and look at the `TriangleView` subclass. You can see it in action by uncommenting line `23` of `TestViewController.swift` and running the project.

### Instagram Behavior

When Instagram's page control has five pages or less, it shows all full dots. Our control doesn't do that by default, but it's easy to recreate. Simply set `maxDots` and `centerDots` to `5` when the number of pages is less than or equal to five, and the default values otherwise.

```swift
if pages <= 5 {
	pageControl.maxDots = 5
	pageControl.centerDots = 5
} else {
	pageControl.maxDots = 7
	pageControl.centerDots = 3
}
pageControl.pages = pages
```

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Installation

ScrollingPageControl is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'ScrollingPageControl'
```

## Author

EmilioPelaez, i.am@emiliopelaez.me

## License

ScrollingPageControl is available under the MIT license. See the LICENSE file for more info.
