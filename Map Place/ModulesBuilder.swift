import Foundation
import UIKit


protocol BuilderProtocol {
    func setAuthViewController() -> UIViewController
    func setLoginViewController() -> UIViewController
    func setSignInViewController() -> UIViewController
    func setMainViewController() -> UIViewController
    func setMessengerViewController(uid: String,
                                    userName: String) -> UIViewController
    func setEditInfoViewController()->UIViewController
}

class Builder: BuilderProtocol{
    func setEditInfoViewController() -> UIViewController {
        let view = EditInfoViewController()
        return view
    }
    
    func setMessengerViewController(uid: String, userName: String) -> UIViewController {
        let view = MessengerViewController()
        view.uid = uid
        view.title = userName
        return view
    }
    
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
