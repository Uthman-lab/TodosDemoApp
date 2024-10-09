//
//  TodoModel.swift
//  TodosDemo
//
//  Created by AMALITECH-PC-593 on 10/4/24.
//

import Foundation

struct TodoModel: Codable, Hashable, Identifiable {
    let userId: Int
    let id: Int
    let title: String
    let completed: Bool
}
