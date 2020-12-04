import Foundation


class Message{
    var text: String?
    var who: String?
    var time: String?
    init(text: String, who: String, time: String) {
        self.text = text
        self.who = who
        self.time = time
    }
}
