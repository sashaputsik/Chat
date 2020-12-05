import UIKit

import FirebaseDatabase
import FirebaseAuth

import NotificationCenter
class MessengerViewController: UIViewController {

    var messages = [Message]()
    var uid: String?
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var bottomTextField: NSLayoutConstraint!
    
    override func viewWillAppear(_ animated: Bool) {
        guard let uid = uid else{return }
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(handle(keyboardShowNotification:)),
                                               name: UIResponder.keyboardDidShowNotification,
                                               object: nil)
        tableView.separatorStyle = .none
        tableView.keyboardDismissMode = .onDrag
        
        setMessages(uid: uid) {
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
    
    func setMessages(uid: String, complitionHandler: @escaping ()->()){
        guard let uidU = Auth.auth().currentUser?.uid else{return }
        let db = FirebaseDatabase.Database.database().reference().child("users").child(uidU).child("messages").child(uid)
        db.observe(.childAdded) { (snapshot) in
                print(snapshot)
                if let dict = snapshot.value as? [String: AnyObject]{
                    guard let text = dict["text"] as? String, let who = dict["who"] as? String, let time = dict["time"] as? String else{return }
                    let message = Message(text: text, who: who, time: time)
                    self.messages.append(message)
                }
            
            complitionHandler()
        } withCancel: { (erorr) in
            print(erorr)
        }

        
            
    }
    
    //MARK: Handler
    @objc
    private
    func handle(keyboardShowNotification notification: Notification) {
        print("Keyboard show notification")
        if let userInfo = notification.userInfo,
            let keyboardRectangle = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
                self.bottomTextField.constant  = 0 - keyboardRectangle.height
                self.textField.layoutIfNeeded()
        }
    }


}
