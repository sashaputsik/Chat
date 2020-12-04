import Foundation

import FirebaseAuth

protocol SignInModuleProtocol {
    func setUser(completed: CompletedAuth,
                 comptionHandler: (()->())?)
}

class SignInModule: SignInModuleProtocol{
    func setUser(completed: CompletedAuth,
                 comptionHandler: (()->())?) {
        switch completed {
        case .success(let user):
            guard let password = user.password else{return }
            Auth.auth().signIn(withEmail: user.email, password: password) {[weak self] (result, error) in
                guard let self = self else{return }
                if error != nil{
                    guard let errorToAuth = error else{return}
                    let error = AuthError(errorDiscription: errorToAuth.localizedDescription, title: "Error")
                    self.setUser(completed: .error(error), comptionHandler: nil)
                }else{
                    comptionHandler?()
                }
                
            }
        case .error(let error):
            print(error.errorDiscription)
        default:
            print("default")
        }
    }
}
