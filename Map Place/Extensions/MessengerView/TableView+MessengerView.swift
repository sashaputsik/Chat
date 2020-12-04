import Foundation
import UIKit


extension MessengerViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = messages?.count else{return 0}
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        guard let message = messages?[indexPath.row] else{return UITableViewCell()}
        cell.textLabel?.text = message.text
        return cell
    }
    
    
}

extension MessengerViewController: UITableViewDelegate{
    
}
