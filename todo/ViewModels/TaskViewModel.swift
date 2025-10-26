import Foundation

class TaskViewModel: ObservableObject {
    @Published var tasks: [TaskItem] = [] {
        didSet { saveTasks() }
    }

    private let tasksKey = "tasks_list"

    init() {
        loadTasks()
    }

    func addTask(title: String, category: String? = nil) {
        let newTask = TaskItem(title: title, category: category)
        tasks.append(newTask)
    }

    func toggleTaskDone(_ task: TaskItem) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks[index].isDone.toggle()
        }
    }

    func deleteTask(at offsets: IndexSet) {
        tasks.remove(atOffsets: offsets)
    }

    private func saveTasks() {
        if let encoded = try? JSONEncoder().encode(tasks) {
            UserDefaults.standard.set(encoded, forKey: tasksKey)
        }
    }

    private func loadTasks() {
        if let savedData = UserDefaults.standard.data(forKey: tasksKey),
           let decoded = try? JSONDecoder().decode([TaskItem].self, from: savedData) {
            tasks = decoded
        }
    }
}
