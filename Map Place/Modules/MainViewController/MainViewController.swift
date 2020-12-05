import UIKit

import FirebaseAuth
import FirebaseDatabase
import FirebaseFirestore
class MainViewController: UIViewController, MainModuleProtocol {
    var users: [User]?
    var presenter: MainModulePresenterProtocol!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.register(UITableViewCell.self,
                           forCellReuseIdentifier: "cell")
    
        getUsersList { (usersInData) in
            self.users = usersInData
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
    }
    @IBAction func signOut(_ sender: Any) {
        try? Auth.auth().signOut()
        navigationController?.pushViewController(Builder().setAuthViewController(),
                                                 animated: true)
    }
    
    //MARK: get Username
    func getUserName()->String{
     var name = ""
        let uid = Auth.auth().currentUser?.uid
        let db = Database.database().reference().child("users").child(uid!)
        db.observeSingleEvent(of: .value) { (snapshot) in
            let value = snapshot.value as? [String: Any]
            let username = value?["name"] as? String
            name = username!
        }
        return name
    }
    
    func getUsersList(complitionHandler: @escaping (([User])->())) {
        var usersInBase = [User]()
        let firestore = Firestore.firestore().collection("userName")
        let back = DispatchQueue.global(qos: .userInteractive)
        back.async {
            firestore.getDocuments { (snapshot, error) in
                guard let data = snapshot?.documents else{return }
                if error != nil{
                    print(error?.localizedDescription)
                }else{
                    for userNames in data{
                        guard let email = userNames["email"]  as? String,
                              let userName = userNames["name"] as? String,
                              let uid = userNames["uid"] as? String else{return }
                        let user = User(name: email, userName: userName, uid: uid, password: nil)
                        guard let currentUser = Auth.auth().currentUser?.email else{return }
                        if currentUser == user.email{
                            print("hello \(currentUser)")
                                self.title = currentUser
                        }else{
                            usersInBase.append(user)
                        }
                    }
                }
                complitionHandler(usersInBase)
            }
        }
    }
}


