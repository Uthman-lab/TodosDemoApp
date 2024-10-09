//
//  TodosViewModel.swift
//  TodosDemo
//
//  Created by AMALITECH-PC-593 on 10/4/24.
//

import Foundation

final class TodosViewModel: ObservableObject {

    // MARK: life cycle methods

    init(service: TodoAPIService) {
        self.service = service
        getTodos()
    }

    // MARK: private variables

    let service: TodoAPIService

    // MARK: state variables

    @Published var oddTodosSection: TodosSection = .init(
        title: .odd,
        todos: []
    )
    @Published var evenTodosSection: TodosSection = .init(
        title: .even,
        todos: []
    )
    @Published var restOfTodosSection: TodosSection = .init(
        title: .rest,
        todos: []
    )

    // MARK: private variables

    private func getTodos() {
        Task {
            do {
                let result = try await service.getTodos()
                DispatchQueue.main.async { [weak self] in
                    let oddTodos = result.filter { $0.id % 3 == 0}
                    let evenTodos = result.filter { $0.id % 2 == 0}
                    let restOfTodos = result.filter { $0.id % 2 != 0 && $0.id % 3 != 0}

                    guard let self = self else {
                        return
                    }
                    self.oddTodosSection = self.setTodos(
                        title: .odd,
                        todos: oddTodos
                    )
                    self.evenTodosSection = self.setTodos(
                        title: .even,
                        todos: evenTodos
                    )
                    self.restOfTodosSection = self.setTodos(
                        title: .rest,
                        todos: restOfTodos
                    )
                }
            } catch {

            }
        }
    }

    private func setTodos(
        title: TodoSectionTitle,
        todos: [TodoModel]
    ) -> TodosSection {
        TodosSection(
            title: title,
            todos: todos
        )
    }
}

enum TodoSectionTitle {
    case even, odd, rest

    var value: String {
        switch self {
        case .even:
            "Even Number Todos"
        case .odd:
            "Multiple of Three Todos"
        case .rest:
            "The Rest of Todos"
        }
    }
}

struct TodosSection: Hashable, Identifiable {
    var id = UUID()
    let title: TodoSectionTitle
    let todos: [TodoModel]
}
