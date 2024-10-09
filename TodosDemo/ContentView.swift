//
//  ContentView.swift
//  TodosDemo
//
//  Created by AMALITECH-PC-593 on 10/4/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var todosViewModel = TodosViewModel(service: TodoAPIService())
    var todos: [TodosSection] {[
        todosViewModel.evenTodosSection,
        todosViewModel.oddTodosSection,
        todosViewModel.restOfTodosSection
    ]}

    var body: some View {
        List {
            ForEach(todos) { section in
                Section(section.title.value) {
                    if section.todos.isEmpty {
                        ProgressView()
                    } else {
                        ForEach(section.todos) { todo in
                            HStack {
                                Text(todo.title)
                                Spacer()
                                Text("\(todo.id)")
                            }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
