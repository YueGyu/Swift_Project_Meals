struct Task {
    var title: String
    var memo: String?
    var done: Bool
    
    init(title: String, memo: String? = nil) {
        self.title = title
        self.memo = memo
        self.done = false
    }
}
