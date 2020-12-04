import Foundation
import UIKit

import FirebaseDatabase
import FirebaseAuth

extension MessengerViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let currentUser = Auth.auth().currentUser else{return true}
        let db = Database.database().reference().child("users").child(currentUser.uid).child("messages").child(uid!)
        let dateFormmater = DateFormatter()
        guard let text = textField.text else{return true}
        let child = db.childByAutoId()
        child.setValue(["text": text, "who": "me", "time": dateFormmater.string(from: Date())])
        
        let dbOtherUser = Database.database().reference().child("users").child(uid!).child("messages").child(currentUser.uid)
        let childOtherUser = dbOtherUser.childByAutoId()
        childOtherUser.setValue(["text": text, "who": "her", "time": dateFormmater.string(from: Date())])
        return true
    }
}
