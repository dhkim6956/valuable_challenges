//
//  publicClass.swift
//  ToChallenge
//
//  Created by 김도훈 on 2021/08/21.
//

import Foundation
import UIKit

public class PickerUITextField: UITextField {
    override public func canPerformAction(_ action: Selector, withSender
                                            sender: Any?) -> Bool {
        if action == #selector(UIResponderStandardEditActions.paste(_:)) {
            return false
        }
        return super.canPerformAction(action, withSender: sender)
    }
    
    override public func caretRect(for position: UITextPosition) -> CGRect {
        return CGRect.zero
    }
}
