import Foundation

protocol MainModuleProtocol {
    var presenter: MainModulePresenterProtocol! { get set }
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
