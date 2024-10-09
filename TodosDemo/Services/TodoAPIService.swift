//
//  TodoAPIService.swift
//  TodosDemo
//
//  Created by AMALITECH-PC-593 on 10/4/24.
//

import Foundation

class TodoAPIService {
    var url: String {
        AppConfig.shared.baseURL
    }

    func getTodos() async throws -> [TodoModel] {
        guard let url =  URL(string: url) else {
            throw Errors.urlError
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        let parsedData = try JSONDecoder().decode([TodoModel].self, from: data)
        return parsedData
    }
}

enum Errors: Error {
    case urlError
}
