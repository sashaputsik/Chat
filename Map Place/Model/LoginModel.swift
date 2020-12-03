import Foundation

//MARK: Login Model

protocol LoginProtocol {
    var email: String { get set }
    var userName: String? { get set }
    var password: String? { get set }
    
    init(name: String, userName: String, password: String)
}

protocol LoginErrorProtocol {
    var errorDiscription: String { get set }
    var title: String { get set }
    init(errorDiscription: String, title: String)
}

class User: LoginProtocol{
    var email: String
    var userName: String?
    var password: String?
    
    required init(name: String, userName: String, password: String) {
        self.email = name
        self.userName = userName
        self.password = password
    }
}

enum CompletedLogin{
    case success(User)
    case error(LoginError)
}

class LoginError: LoginErrorProtocol{
    var errorDiscription: String
    
    var title: String
    
    required init(errorDiscription: String, title: String) {
        self.errorDiscription = errorDiscription
        self.title = title
    }
}
