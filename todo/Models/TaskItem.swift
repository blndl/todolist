import Foundation

struct TaskItem: Identifiable, Codable {
    var id = UUID()
    var title: String
    var isDone: Bool = false
    var category: String? = nil
}

