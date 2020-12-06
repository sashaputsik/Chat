import Foundation
import UIKit

extension UIViewController{
    func alert(title: String, message: String)-> UIAlertController{
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)
        let okeyAction = UIAlertAction(title: "Oket",
                                       style: .default,
                                       handler: nil)
        alertController.addAction(okeyAction)
        return alertController
    }
}
