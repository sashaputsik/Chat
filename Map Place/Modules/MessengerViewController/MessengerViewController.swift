import UIKit

import FirebaseDatabase
import FirebaseAuth

class MessengerViewController: UIViewController {

    var messages = [Message]()
    var uid: String?
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textField: UITextField!
    
    override func viewWillAppear(_ animated: Bool) {
        print(uid!)
        setMessages(uid: uid!) { (messages) in
            DispatchQueue.main.async {
                self.tableView.reloadData() 
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self,
                           forCellReuseIdentifier: "cell")
        
    }
    func setMessages(uid: String, complitionHandler: @escaping ([Message])->()){
        guard let uidU = Auth.auth().currentUser?.uid else{return }
        let db = FirebaseDatabase.Database.database().reference().child("users").child(uidU).child("messages").child(uid)
        db.observe(.childAdded) { (snapshot) in
                print(snapshot)
                if let dict = snapshot.value as? [String: AnyObject]{
                    guard let text = dict["text"] as? String, let who = dict["who"] as? String, let time = dict["time"] as? String else{return }
                    let message = Message(text: text, who: who, time: time)
                    self.messages.append(message)
                }
            
            complitionHandler(self.messages)
        } withCancel: { (erorr) in
            print(erorr)
        }

        
            
    }
    

}
