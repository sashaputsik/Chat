import Foundation

//MARK: User Model

protocol AuthProtocol {
    var email: String { get set }
    var userName: String? { get set }
    var uid: String? {get set}
    var password: String? {get set}
    init(name: String, userName: String, uid: String, password: String?)
}

protocol AuthErrorProtocol {
    var errorDiscription: String { get set }
    var title: String { get set }
    init(errorDiscription: String, title: String)
}

class User: AuthProtocol{
    var email: String
    var userName: String?
    var uid: String?
    var password: String?
    
    required init(name: String, userName: String, uid: String, password: String?) {
        self.email = name
        self.userName = userName
        self.uid = uid
        self.password = password
    }
}

enum CompletedAuth{
    case success(User)
    case error(AuthError)
}

class AuthError: AuthErrorProtocol{
    var errorDiscription: String
    
    var title: String
    
    required init(errorDiscription: String, title: String) {
        self.errorDiscription = errorDiscription
        self.title = title
    }
}
