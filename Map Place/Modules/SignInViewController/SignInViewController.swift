import UIKit

class SignInViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    var signInModule: SignInModule!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = false
        signInButton.layer.cornerRadius = UIButton.Appearance().cornerRadius
        signInButton.layer.borderWidth = UIButton.Appearance().borderWidth
        signInButton.layer.borderColor = UIButton.Appearance().borderColor?.cgColor
        signInButton.addTarget(self,
                               action: #selector(signIn),
                               for: .touchUpInside)
        
    }
    //MARK: Handler
    
    @objc
    private func signIn(){
        signInModule = SignInModule()
        guard let email = emailTextField.text,
              let password = passwordTextField.text else{return }
        if email.trimmingCharacters(in: .whitespacesAndNewlines) != "" &&
            password.trimmingCharacters(in: .whitespacesAndNewlines) != ""{
            
            let user = User(name: email, userName: "", uid: "", password: password)
            signInModule.setUser(completed: .success(user)) {
                self.navigationController?.pushViewController(Builder().setMainViewController(),
                                                             animated: true)
            }
        }else{
            let error = AuthError(errorDiscription: "Empty fields", title: "Error")
            signInModule.setUser(completed: .error(error),
                                 comptionHandler: nil)
        }
    }
    
}

