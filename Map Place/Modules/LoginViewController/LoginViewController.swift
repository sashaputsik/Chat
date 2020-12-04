import Firebase
import FirebaseAuth
import FirebaseDatabase
import FirebaseFirestore
import UIKit

class LoginViewController: UIViewController, LoginModuleProtocol{

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var infoTextField: UITextView!
    @IBOutlet weak var repeatePasswordTextField: UITextField!
    @IBOutlet weak var completedButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = false
        let tap = UITapGestureRecognizer(target: self,
                                         action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        completedButton.layer.cornerRadius = UIButton.Appearance().cornerRadius
        completedButton.addTarget(self,
                                  action: #selector(completed),
                                  for: .touchUpInside)
    }
    
    //MARK: Handlers
    
    @objc
    private func completed(){
        if emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) != "" &&
            repeatePasswordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) != "" &&
            repeatePasswordTextField.text == passwordTextField.text {
            guard let email = emailTextField.text,
                  let password = repeatePasswordTextField.text,
                  let userName = userNameTextField.text else{return }
            let user = User(name: email, userName: userName, uid: "", password: password)
            createNewUser(completed: CompletedAuth.success(user))
        }else{
            let error = AuthError(errorDiscription: "Worth fields", title: "Error")
            createNewUser(completed: CompletedAuth.error(error))
        }
    }
    
    @objc
    private func dismissKeyboard(){
        view.resignFirstResponder()
    }
    
    func createNewUser(completed: CompletedAuth){
        switch completed {
        case .success(let user):
            guard let password = passwordTextField.text else{return }
            Auth.auth().createUser(withEmail: user.email,
                                   password: password) { (result,
                                                          error) in
                if error != nil{
                    guard let error = error else{return }
                    let loginError = AuthError(errorDiscription: error.localizedDescription, title: "Error")
                    self.createNewUser(completed: CompletedAuth.error(loginError))
                }
                let uid = Auth.auth().currentUser?.uid
                let db =  Database.database().reference().child("users")
                db.child(uid!).updateChildValues(["name": user.email])
                
                let firestore = Firestore.firestore().collection("userName")
                firestore.addDocument(data: ["email": user.email, "name": user.userName!, "uid": uid!])
                self.navigationController?.pushViewController(Builder().setMainViewController(), animated: true)
            }
        case .error(let error):
            print(error.errorDiscription)
        default:
            print("defaut")
        }
    }

    
}


