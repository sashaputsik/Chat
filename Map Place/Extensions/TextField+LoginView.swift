import Foundation
import UIKit

extension LoginViewController: UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
    }
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let password = textField.text else{return }
        guard let repeatePassword = textField.text else{return }
        if textField == passwordTextField{
            textField.layer.borderWidth = 2
            if password.count >= 8{
                textField.layer.borderColor = UIColor.systemGreen.cgColor
            }else{
                textField.layer.borderColor = UIColor.red.cgColor
            }
            textField.layer.cornerRadius = 4
        }
    }
}
