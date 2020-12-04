import Foundation
import UIKit


extension MessengerViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = messages[indexPath.row].text
        if messages[indexPath.row].who == "me"{
            cell.textLabel?.textAlignment = .right
        }else{
            cell.textLabel?.textAlignment = .left
        }
        return cell
    }
    
    
}

extension MessengerViewController: UITableViewDelegate{
    
}
