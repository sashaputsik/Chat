import UIKit

import FirebaseDatabase
import FirebaseAuth

import NotificationCenter
class MessengerViewController: UIViewController {

    var messages = [Message]()
    var uid: String?
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet var bottom: [NSLayoutConstraint]!
    override func viewWillAppear(_ animated: Bool) {
        guard let uid = uid else{return }
        sendButton.addTarget(self,
                             action: #selector(send),
                             for: .touchUpInside)
        sendButton.layer.cornerRadius = sendButton.frame.height/2
        navigationController?.isNavigationBarHidden = false
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(handle(keyboardShowNotification:)),
                                               name: UIResponder.keyboardDidShowNotification,
                                               object: nil)
        tableView.separatorStyle = .none
        tableView.keyboardDismissMode = .onDrag
        
        setMessages(uid: uid) {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else{return }
                self.tableView.reloadData()
                let indexPath = IndexPath(item: self.messages.count-1,
                                          section: 0)
                self.tableView.scrollToRow(at: indexPath,
                                           at: .bottom,
                                           animated: true)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(MessageTableViewCell.self,
                           forCellReuseIdentifier: "cell")
        
    }
    
    func setMessages(uid: String,
                     complitionHandler: @escaping ()->()){
        guard let uidU = Auth.auth().currentUser?.uid else{return }
        let db = FirebaseDatabase.Database.database().reference().child("users").child(uidU).child("messages").child(uid)
        db.observe(.childAdded) { (snapshot) in
                print(snapshot)
                if let dict = snapshot.value as? [String: AnyObject]{
                    guard let text = dict["text"] as? String, let who = dict["who"] as? String, let time = dict["time"] as? String else{return }
                    let message = Message(text: text,
                                          who: who,
                                          time: time)
                    self.messages.append(message)
                }
            
            complitionHandler()
        } withCancel: { (erorr) in
            print(erorr)
        }
    }
    
    func pushMessage(text: String){
        guard let currentUser = Auth.auth().currentUser else{return }
        guard let uid = uid else{return }
        let db = Database.database().reference().child("users").child(currentUser.uid).child("messages").child(uid)
        let dateFormmater = DateFormatter()
        let child = db.childByAutoId()
        child.setValue(["text": text,
                        "who": "me",
                        "time": dateFormmater.string(from: Date())])
        
        let dbOtherUser = Database.database().reference().child("users").child(uid).child("messages").child(currentUser.uid)
        let childOtherUser = dbOtherUser.childByAutoId()
        childOtherUser.setValue(["text": text,
                                 "who": "her",
                                 "time": dateFormmater.string(from: Date())])
    }
    
    //MARK: Handler
    @objc
    private
    func handle(keyboardShowNotification notification: Notification) {
        print("Keyboard show notification")
        if let userInfo = notification.userInfo,
            let keyboardRectangle = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
            for constrain in self.bottom{
                constrain.constant  = 0 - keyboardRectangle.height - 5
               
                self.textField.layoutIfNeeded()
            }
            let indexPath = IndexPath(item: self.messages.count-1,
                                      section: 0)
            self.tableView.scrollToRow(at: indexPath,
                                       at: .bottom,
                                       animated: true)
        }
    }
    
    @objc
    private
    func send(){
        guard let text = textField.text else{return }
        if textField.text?.trimmingCharacters(in: .whitespacesAndNewlines) != ""{
            pushMessage(text: text)
        }
        textField.text = ""
    }


}
