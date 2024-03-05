//
//  File.swift
//  
//
//  Created by Igor Łopatka on 05/03/2024.
//

import Foundation
import Fluent

class CreateCategoryTable: AsyncMigration {
    
    func prepare(on database: Database) async throws {
        try await database.schema("categories")
            .id()
            .field("title", .string, .required)
            .field("color", .string, .required)
            .field("userid", .uuid, .required, .references("users", "id"))
            .create()
    }
    
    func revert(on database: Database) async throws {
        try await database.schema("categories").delete()
    }
    
    
    
}
