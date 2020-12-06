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
        navigationController?.isNavigationBarHidden = false
        
        let leftButton = UIBarButtonItem(title: "Edit info",
                                         style: .done,
                                         target: self,
                                         action: #selector(editInfo))
        let rigthButton = UIBarButtonItem(title: "Search",
                                          style: .done,
                                          target: self,
                                          action: #selector(search))
        navigationItem.leftBarButtonItem = leftButton
        navigationItem.rightBarButtonItem = rigthButton
        
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
            firestore.getDocuments {[weak self] (snapshot, error) in
                guard let self = self else{return }
                guard let data = snapshot?.documents else{return }
                if error != nil{
                    guard let error = error else{return }
                    print(error.localizedDescription)
                }else{
                    for userNames in data{
                        guard let email = userNames["email"]  as? String,
                              let userName = userNames["name"] as? String,
                              let uid = userNames["uid"] as? String else{return }
                        let user = User(name: email, userName: userName, uid: uid, password: nil)
                        guard let currentUser = Auth.auth().currentUser?.email else{return }
                        if currentUser == user.email{
                            self.title = user.userName
                        }else{
                            usersInBase.append(user)
                        }
                    }
                }
                complitionHandler(usersInBase)
            }
        }
    }
    
    //MARK: Handler
    @objc
    private func editInfo(){
        navigationController?.pushViewController(Builder().setEditInfoViewController(),
                                                 animated: true)
    }
    
    @objc
    private func search(){
        
    }
}


