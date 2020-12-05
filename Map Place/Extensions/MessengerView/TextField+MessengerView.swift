import Foundation
import UIKit

import FirebaseDatabase
import FirebaseAuth

extension MessengerViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let text = textField.text else{return true}
        pushMessage(text: text)
        textField.text = ""
        
        return true
    }
}
