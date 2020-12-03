import UIKit

fileprivate typealias Appearance = UIButton.Appearance

class AuthViewController: UIViewController {

    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        signInButton.layer.cornerRadius = Appearance().cornerRadius
        signInButton.layer.borderWidth = Appearance().borderWidth
        signInButton.layer.borderColor = Appearance().borderColor?.cgColor
        loginButton.layer.cornerRadius = Appearance().cornerRadius
        loginButton.addTarget(self,
                              action: #selector(login),
                              for: .touchUpInside)
        signInButton.addTarget(self,
                               action: #selector(signIn),
                               for: .touchUpInside)
    }
    
    //MARK: Handlers
    @objc
    private func signIn(){
        navigationController?.pushViewController(Builder().setSignInViewController(),
                                                 animated: true)
    }
    
    @objc
    private func login(){
        navigationController?.pushViewController(Builder().setLoginViewController(),
                                                 animated: true)
    }
    
   
}

extension UIButton{
    struct Appearance{
        let cornerRadius: CGFloat = 10.0
        let shadowOpacity = 0.5
        let shadowPath = CGSize(width: 1,
                                height: 1)
        let borderWidth: CGFloat = 2
        let borderColor = UIColor(named: "SystemLight")

    }
}
