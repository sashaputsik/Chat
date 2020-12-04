import Foundation

protocol MainModuleProtocol {
    var presenter: MainModulePresenterProtocol! { get set }
    var users: [User]? {get set}
    func getUsersList(complitionHandler: @escaping (([User])->()))
}

protocol MainModulePresenterProtocol {
    var view: MainModuleProtocol! { get set }
    
    init(view: MainModuleProtocol)
}

class MainModulePresenter: MainModulePresenterProtocol{
    var view: MainModuleProtocol!
    
    
    required init(view: MainModuleProtocol) {
        self.view = view
    }
    
    
}
