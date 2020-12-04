import Foundation

protocol MessageProtocol {
    var text: String { get set }
    var who: String { get set }
    var time: String { get set }
    init(text: String, who: String, time: String)
}

class Message: MessageProtocol{
    var text: String
    var who: String
    var time: String
    
    required init(text: String, who: String, time: String) {
        self.text = text
        self.who = who
        self.time = time
    }
    
    
}
