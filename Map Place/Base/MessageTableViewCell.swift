import UIKit

class MessageTableViewCell: UITableViewCell {
    let messageLabel = UILabel()
    let backgroundMessageView = UIView()
    var leadingForText: NSLayoutConstraint!
    var trailingForText: NSLayoutConstraint!
    var isIncoming: Bool! {
        didSet{
            backgroundMessageView.backgroundColor = isIncoming ? UIColor(named: "HerMessage") : UIColor(named: "MyMessage")
            leadingForText.isActive = isIncoming ? true : false
            trailingForText.isActive = isIncoming ? false : true
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        backgroundMessageView.layer.cornerRadius = 12
        backgroundMessageView.translatesAutoresizingMaskIntoConstraints = false
        backgroundMessageView.backgroundColor = .red
        addSubview(backgroundMessageView)
        
        messageLabel.numberOfLines = 0
        messageLabel.translatesAutoresizingMaskIntoConstraints  = false
        addSubview(messageLabel)
        
        let constraints = [messageLabel.topAnchor.constraint(equalTo: topAnchor, constant: 32),
                           messageLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -32),
                           messageLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 200),
                           backgroundMessageView.topAnchor.constraint(equalTo: messageLabel.topAnchor, constant: -16),
                           backgroundMessageView.leadingAnchor.constraint(equalTo: messageLabel.leadingAnchor, constant: -16),
                           backgroundMessageView.bottomAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 16),
                           backgroundMessageView.trailingAnchor.constraint(equalTo: messageLabel.trailingAnchor, constant: 16)
        ]
        NSLayoutConstraint.activate(constraints)
        leadingForText =  messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32)
        leadingForText.isActive = false
        trailingForText =  messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32)
        trailingForText.isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
