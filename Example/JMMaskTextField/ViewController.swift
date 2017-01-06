//
//  ViewController.swift
//  JMMaskTextField
//
//  Created by Jota Melo on 01/05/2017.
//  Copyright (c) 2017 Jota Melo. All rights reserved.
//

import UIKit
import JMMaskTextField

class ViewController: UIViewController, UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        guard let text = textField.text as NSString? else { return true }
        let newText = text.replacingCharacters(in: range, with: string)
        
        let maskTextField = textField as! JMMaskTextField
        guard let unmaskedText = maskTextField.stringMask?.unmask(string: newText) else { return true }
        
        if unmaskedText.characters.count >= 11 {
            maskTextField.maskString = "(00) 0 0000-0000"
        } else {
            maskTextField.maskString = "(00) 0000-0000"
        }
        
        return true
    }
    
}
