import UIKit

import FirebaseDatabase

class MessengerViewController: UIViewController {

    var messages: [Message]?
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self,
                           forCellReuseIdentifier: "cell")
        
    }
    

}
