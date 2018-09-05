//
//  JMMaskTextField.swift
//  JMMaskTextField Swift
//
//  Created by Jota Melo on 02/01/17.
//  Copyright © 2017 Jota. All rights reserved.
//

import UIKit

open class JMMaskTextField: UITextField {

    // damn, maskView is just mask in Swift
    public private(set) var stringMask: JMStringMask?
    fileprivate weak var realDelegate: UITextFieldDelegate?
    
    override weak open var delegate: UITextFieldDelegate? {
        get {
            return self.realDelegate
        }
        
        set (newValue) {
            self.realDelegate = newValue
            super.delegate = self
        }
    }
    
    public var unmaskedText: String? {
        get {
            return self.stringMask?.unmask(string: self.text) ?? self.text
        }
    }
    
    @IBInspectable open var maskString: String? {
        didSet {
            guard let maskString = self.maskString else { return }
            self.stringMask = JMStringMask(mask: maskString)
        }
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        
        self.commonInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.commonInit()
    }
    
    override open func awakeFromNib() {
        super.awakeFromNib()
        
        self.commonInit()
    }
    
    func commonInit() {
        super.delegate = self
    }
    
}

extension JMMaskTextField: UITextFieldDelegate {
    
    public func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return self.realDelegate?.textFieldShouldBeginEditing?(textField) ?? true
    }
    
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        self.realDelegate?.textFieldDidBeginEditing?(textField)
    }
    
    public func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return self.realDelegate?.textFieldShouldEndEditing?(textField) ?? true
    }
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
        self.realDelegate?.textFieldDidEndEditing?(textField)
    }
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let previousMask = self.stringMask
        let currentText: NSString = textField.text as NSString? ?? ""
        
        if let realDelegate = self.realDelegate, realDelegate.responds(to: #selector(textField(_:shouldChangeCharactersIn:replacementString:))) {
            let delegateResponse = realDelegate.textField!(textField, shouldChangeCharactersIn: range, replacementString: string)
            
            if !delegateResponse {
                return false
            }
        }
        
        guard let mask = self.stringMask else { return true }
        
        let newText = currentText.replacingCharacters(in: range, with: string)
        var formattedString = mask.mask(string: newText)
        
        // if the mask changed or if the text couldn't be formatted,
        // unmask the newText and mask it again
        if (previousMask != nil && mask != previousMask!) || formattedString == nil {
            let unmaskedString = mask.unmask(string: newText)
            formattedString = mask.mask(string: unmaskedString)
        }
        
        guard let finalText = formattedString as NSString? else { return false }
        
        // if the cursor is not at the end and the string hasn't changed
        // it means the user tried to delete a mask character, so we'll
        // change the range to include the character right before it
        if finalText == currentText && range.location < currentText.length && range.location > 0 {
            return self.textField(textField, shouldChangeCharactersIn: NSRange(location: range.location - 1, length: range.length + 1) , replacementString: string)
        }
        
        if finalText != currentText {
            textField.text = finalText as String
            
            // the user is trying to delete something so we need to
            // move the cursor accordingly
            if range.location < currentText.length {
                var cursorLocation = 0
                
                if range.location > finalText.length {
                    cursorLocation = finalText.length
                } else if currentText.length > finalText.length {
                    cursorLocation = range.location
                } else {
                    cursorLocation = range.location + 1
                }
                
                guard let startPosition = textField.position(from: textField.beginningOfDocument, offset: cursorLocation) else { return false }
                guard let endPosition = textField.position(from: startPosition, offset: 0) else { return false }
                textField.selectedTextRange = textField.textRange(from: startPosition, to: endPosition)
            }
            
            return false
        }
        
        return true
    }
    
    public func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return self.realDelegate?.textFieldShouldClear?(textField) ?? true
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return self.realDelegate?.textFieldShouldReturn?(textField) ?? true
    }
    
}
