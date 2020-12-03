import Firebase
import FirebaseAuth

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
        passwordTextField.isSecureTextEntry = true
        repeatePasswordTextField.isSecureTextEntry = true
        
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
            let user = User(name: email,
                             userName: userName,
                             password: password)
            createNewUser(completed: CompletedLogin.success(user))
        }else{
            let error = LoginError(errorDiscription: "Worth fields", title: "Error")
            createNewUser(completed: CompletedLogin.error(error))
        }
    }
    
    @objc
    private func dismissKeyboard(){
        view.resignFirstResponder()
    }
    
    func createNewUser(completed: CompletedLogin){
        switch completed {
        case .success(let user):
            guard let password = user.password else{return }
            Auth.auth().createUser(withEmail: user.email,
                                   password: password) { (result,
                                                          error) in
                guard let result = result else{return }
                
                if error != nil{
                    guard let error = error else{return }
                    let loginError = LoginError(errorDiscription: error.localizedDescription, title: "Error")
                    self.createNewUser(completed: CompletedLogin.error(loginError))
                }
                
                let user = User(name: user.email, userName: "", password: "")
                UserDefaults.standard.set(user.email, forKey: "email")
                self.navigationController?.pushViewController(Builder().setMainViewController(), animated: true)
            }
        case .error(let error):
            print(error.errorDiscription)
        default:
            print("defaut")
        }
    }

    
}


