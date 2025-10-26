import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = TaskViewModel()
    @State private var newTaskTitle = ""
    @State private var filter = "All"
    
    var filteredTasks: [TaskItem] {
        switch filter {
        case "Done": return viewModel.tasks.filter { $0.isDone }
        case "Pending": return viewModel.tasks.filter { !$0.isDone }
        default: return viewModel.tasks
        }
    }

    var body: some View {
        NavigationView {
            VStack(spacing: 12) {
                
                HStack {
                    TextField("New Task", text: $newTaskTitle)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.leading, 4)
                    Button(action: {
                        guard !newTaskTitle.isEmpty else { return }
                        viewModel.addTask(title: newTaskTitle)
                        newTaskTitle = ""
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .font(.title2)
                    }
                }
                .padding(.horizontal)
                
                Picker("Filter", selection: $filter) {
                    Text("All").tag("All")
                    Text("Done").tag("Done")
                    Text("Pending").tag("Pending")
                }
                .pickerStyle(.segmented)
                .padding(.horizontal)
                
                List {
                    ForEach(filteredTasks) { task in
                        HStack {
                            Image(systemName: task.isDone ? "checkmark.circle.fill" : "circle")
                                .foregroundColor(task.isDone ? .green : .gray)
                                .onTapGesture { viewModel.toggleTaskDone(task) }
                            
                            Text(task.title)
                                .strikethrough(task.isDone)
                                .foregroundColor(task.isDone ? .gray : .primary)
                        }
                    }
                    .onDelete(perform: viewModel.deleteTask)
                }
            }
            .navigationTitle("📝 To-Do List")
        }
    }
}

#Preview {
    ContentView()
}
