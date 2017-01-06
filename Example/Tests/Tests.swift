import UIKit
import XCTest
import JMMaskTextField

class Tests: XCTestCase {
    
    func testStringMask() {
        
        var mask = JMStringMask(mask: "00000-000")
        
        XCTAssertEqual(mask.mask(string: "abcbe-343"), nil)
        XCTAssertEqual(mask.mask(string: "30310360"), "30310-360")
        XCTAssertEqual(mask.mask(string: "30310-360"), "30310-360")
        XCTAssertEqual(mask.mask(string: "303103600"), nil)
        XCTAssertEqual(mask.mask(string: nil), nil)
        
        mask = JMStringMask(mask: "AAA-0000")
        XCTAssertEqual(mask.mask(string: "123-EIEIEIEIE"), nil)
        XCTAssertEqual(mask.mask(string: "ETO1192"), "ETO-1192")
        XCTAssertEqual(mask.mask(string: "ETO-1192"), "ETO-1192")
        XCTAssertEqual(mask.mask(string: "ETO11922"), nil)
    }
    
    func testTextFieldMask() {
        
        let textField = JMMaskTextField(frame: CGRect.zero)
        textField.maskString = "00000-000"
        
        // pasting
        _ = textField.textField(textField, shouldChangeCharactersIn: NSRange(location: 0, length: 0), replacementString: "30310-360")
        XCTAssertEqual(textField.text, "30310-360")
        
        textField.text = ""
        
        // pasting unformatted
        _ = textField.textField(textField, shouldChangeCharactersIn: NSRange(location: 0, length: 0), replacementString: "30310360")
        XCTAssertEqual(textField.text, "30310-360")
        
        textField.text = ""
        
        // pasting invalid
        _ = textField.textField(textField, shouldChangeCharactersIn: NSRange(location: 0, length: 0), replacementString: "30310-3600")
        XCTAssertEqual(textField.text, "")
        
        textField.text = "30310-360"
        
        // deleting from middle
        _ = textField.textField(textField, shouldChangeCharactersIn: NSRange(location: 2, length: 1), replacementString: "")
        XCTAssertEqual(textField.text, "30103-60")
    }
    
}
