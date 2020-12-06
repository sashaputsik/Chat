import Foundation
import UIKit

import FirebaseDatabase
import FirebaseAuth

extension MainViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = users?.count else{return 0}
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        guard let user = users?[indexPath.row] else{return UITableViewCell()}
        cell.textLabel?.text = user.userName
        cell.detailTextLabel?.text = user.email
        return cell
    }
    
    
}

extension MainViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let uid = users?[indexPath.row].uid else{return}
        guard let userName = users?[indexPath.row].userName else{return }
        navigationController?.pushViewController(Builder().setMessengerViewController(uid: uid,
                                                                                      userName: userName),
                                                 animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            guard let deletedUserUid = users?[indexPath.row].uid else{return }
            guard let currentUserUid = Auth.auth().currentUser?.uid else{return }
            let deletedDatabase = Database.database().reference().child("users").child(currentUserUid).child("").child(deletedUserUid)
            print(deletedDatabase)
            deletedDatabase.removeValue { [weak self] (error, _) in
                guard let self = self else{return }
                self.users?.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath],
                                     with: .left)
                if error != nil{
                    guard let error = error else{return }
                    print(error.localizedDescription)
                }
            }
            deletedDatabase.observeSingleEvent(of: .childRemoved) { (snapshot) in
                tableView.reloadData()
                print(snapshot.value)
            }
        }
    }
}
