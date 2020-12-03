import Foundation
import UIKit


protocol BuilderProtocol {
    func setAuthViewController() -> UIViewController
    func setLoginViewController() -> UIViewController
    func setSignInViewController() -> UIViewController
    func setMainViewController() -> UIViewController
}

class Builder: BuilderProtocol{
    func setMainViewController() -> UIViewController {
        let view = MainViewController()
        let presenter = MainModulePresenter(view: view)
        view.presenter = presenter
        
        return view
    }
    
    func setLoginViewController() -> UIViewController {
        let view = LoginViewController()
        return view
    }
    
    func setSignInViewController() -> UIViewController {
        let view = SignInViewController()
        return view
    }
    
    func setAuthViewController() -> UIViewController {
        let view = AuthViewController()
        return view
    }
}
