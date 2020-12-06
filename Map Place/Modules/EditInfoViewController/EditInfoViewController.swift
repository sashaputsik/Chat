import UIKit

import FirebaseAuth
import FirebaseFirestore

class EditInfoViewController: UIViewController {

    @IBOutlet weak var newUserNameTextField: UITextField!
    @IBOutlet weak var setNewUserNameButton: UIButton!
    @IBOutlet weak var changePasswordButton: UIButton!
    @IBOutlet weak var signOutButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        setNewUserNameButton.layer.cornerRadius = UIButton.Appearance().cornerRadius
        setNewUserNameButton.layer.borderWidth = UIButton.Appearance().borderWidth
        setNewUserNameButton.layer.borderColor = UIButton.Appearance().borderColor?.cgColor
        setNewUserNameButton.addTarget(self,
                                       action: #selector(changeUserName),
                                       for: .touchUpInside)
        changePasswordButton.layer.cornerRadius = UIButton.Appearance().cornerRadius
        changePasswordButton.layer.borderWidth = UIButton.Appearance().borderWidth
        changePasswordButton.layer.borderColor = UIButton.Appearance().borderColor?.cgColor
        changePasswordButton.addTarget(self,
                                       action: #selector(changePassword),
                                       for: .touchUpInside)
        signOutButton.layer.cornerRadius = UIButton.Appearance().cornerRadius
        signOutButton.addTarget(self,
                                action: #selector(signOut),
                                for: .touchUpInside)
    }
    
    //MARK: Handlers
    
    @objc
    private func signOut(){
        try? Auth.auth().signOut()
        navigationController?.pushViewController(Builder().setAuthViewController(),
                                                 animated: true)
    }
    
    @objc
    private func changeUserName(){
        let userNames = Firestore.firestore().collection("userName")
        userNames.getDocuments {[weak self] (snapshot, error) in
            guard let self = self else{return }
            if error != nil{
                guard let error = error else{return}
                print(error.localizedDescription)
            }else{
                guard let data = snapshot?.documents else{return }
                guard let uid = Auth.auth().currentUser?.uid else{return }
                var newNameToData = ""
                guard let newName = self.newUserNameTextField.text else{return }
                for user in data{
                    let dataUid = user["uid"] as? String
                    let userName = user["name"] as? String
                    if newName != userName{
                        newNameToData = newName
                    }else{
                        self.newUserNameTextField.placeholder = "non"
                        self.newUserNameTextField.text = ""
                        break
                    }
                    
                    if dataUid == uid{
                        user.reference.updateData(["name": newNameToData])
                        self.newUserNameTextField.text = ""
                        self.newUserNameTextField.placeholder = newNameToData
                        self.newUserNameTextField.endEditing(true)
                        self.present(UIViewController().alert(title: "Success", message: "Change new name"),
                                animated: true,
                                completion: nil)
                    }
                }
            }
        }
    }
    
    @objc
    private func changePassword(){
        
    }

}

