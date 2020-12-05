import Foundation
import UIKit

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
}
