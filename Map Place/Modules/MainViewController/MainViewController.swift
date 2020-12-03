import UIKit
import FirebaseAuth

class MainViewController: UIViewController, MainModuleProtocol {
    
    var presenter: MainModulePresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        let cUser = Auth.auth().currentUser
        print(cUser?.email)
    }
    

}
