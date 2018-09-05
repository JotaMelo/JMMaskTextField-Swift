# JMMaskTextField

[![CI Status](http://img.shields.io/travis/JotaMelo/JMMaskTextField-Swift.svg?style=flat)](https://travis-ci.org/JotaMelo/JMMaskTextField-Swift)
[![Version](https://img.shields.io/cocoapods/v/JMMaskTextField-Swift.svg?style=flat)](http://cocoapods.org/pods/JMMaskTextField-Swift)
[![License](https://img.shields.io/cocoapods/l/JMMaskTextField-Swift.svg?style=flat)](http://cocoapods.org/pods/JMMaskTextField-Swift)
[![Platform](https://img.shields.io/cocoapods/p/JMMaskTextField-Swift.svg?style=flat)](http://cocoapods.org/pods/JMMaskTextField-Swift)


Back in my JavaScript days (oh what dark ages) it was quite simple to apply a mask to an input with some jQuery plugin, you just had to set the mask to something like ```(999) 999-9999``` and you had a great masked input for a phone number.
I never found anything that simple on iOS. Some libs required you to write a regex pattern and other crazy stuff. Sure, that can be useful for more complex cases, but I just wanted something simple and straightforward. From that need came ```JMMaskTextField```.

```JMMaskTextField``` allows you to mask your ```UITextField``` by simply setting a mask pattern string. Mask characters are:
* `A` for letters
* `0` for numbers

So for a Brazilian license plate, which has 3 letters, a dash and then 4 numbers, the mask would be: ```AAA-0000```.

```JMMaskTextField``` also handles pasting, inserting and deleting from the middle.

There's also an [Objective-C version](https://github.com/JotaMelo/JMMaskTextField)

## Installation

### CocoaPods

You can install ```JMMaskTextField``` with [CocoaPods](http://cocoapods.org)

* Add this line to your Podfile ```pod "JMMaskTextField-Swift"```
* Run ```pod install```

### Manual

Just drop the JMMaskTextField folder in your project and you're all set!

## Usage

Funcionality is broken down into 2 classes:

* ```JMStringMask``` - all the string masking functionality. You can use this yourself outside of the ```JMMaskTextField```.
* ```JMMaskTextField``` - the ```UITextField``` subclass, handling all editing events. Uses an instance of ```JMStringMask```.

### Interface Builder
Set the class of your text field to ```JMMaskTextField``` in the Identity Inspector. And then on the Attributes Inspector set your mask. And that's it!

![](http://i.imgur.com/HPFXSQC.png)

![](http://i.imgur.com/rIWUNC3.png)

### Code
Initialize an instance of ```JMMaskTextField``` and set the mask property:
```swift

let maskTextField = JMMaskTextField(frame: CGRect.zero)
maskTextField.maskString = "(00) 0 0000-0000"
```
And that's it!

### JMStringMask
You can use the string masking functionality outside of the text field. Usage is also simple:
```swift
let mask = JMStringMask(mask: "00000-000")
let maskedString = mask.mask(string: "30310360") // returns "30310-360"
let unmaskedString = mask.unmask(string: maskedString) // returns "30310360"
```

### Changing the mask while editing
In Brazil we a problem: cell phone numbers are 9 digits (and until recently not all of them were 9 digits), and landlines are 8 digits. That creates a problem with masking. ```JMMaskTextField``` supports changing the mask while editing. So when we identify the user typed a 9 digit number, we switch the mask to the longer format. If they delete a digit, we go back to the original mask. An example:
```swift
func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    
    guard let text = textField.text as NSString? else { return true }
    let newText = text.replacingCharacters(in: range, with: string)
    
    let maskTextField = textField as! JMMaskTextField
    guard let unmaskedText = maskTextField.stringMask?.unmask(string: newText) else { return true }
    
    if unmaskedText.count >= 11 {
        maskTextField.maskString = "(00) 0 0000-0000"
    } else {
        maskTextField.maskString = "(00) 0000-0000"
    }
    
    return true
}
```

## Author

[Jota Melo](https://twitter.com/Jota), jpmfagundes@gmail.com

## License

JMMaskTextField is available under the MIT license. See the LICENSE file for more info.
