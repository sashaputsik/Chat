import Foundation
import UIKit


extension MessengerViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? MessageTableViewCell else{return UITableViewCell()}
        cell.messageLabel.text = messages[indexPath.row].text
        cell.isIncoming = messages[indexPath.row].who == "me" ? false : true
        return cell
    }
    
    
}

extension MessengerViewController: UITableViewDelegate{
    
}
