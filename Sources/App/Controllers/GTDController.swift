//
//  File.swift
//  
//
//  Created by Igor Łopatka on 05/03/2024.
//

import Fluent
import Foundation
import Vapor
import GettingThingsDoneSharedDTO

class GTDController: RouteCollection {
    
    func boot(routes: Vapor.RoutesBuilder) throws {
        
        let api = routes.grouped("api", "users", ":userid")
        api.post("categories", use: saveCategory)
        api.get("categories", use: getCategoriesByUser)
    }
    
    func saveCategory(req: Request) async throws -> CategoryResponseDTO {
        
        guard let userID = req.parameters.get("userid", as: UUID.self) else {
            throw Abort(.badRequest)
        }
        
        let categoryRequest = try req.content.decode(CategoryRequestDTO.self)
        let category = Category(title: categoryRequest.title, color: categoryRequest.color, userid: userID)
        
        try await category.save(on: req.db)
        
        guard let categoryResponse = CategoryResponseDTO(category) else {
            throw Abort(.internalServerError)
        }
        
        return categoryResponse
    }
    
    func getCategoriesByUser(req: Request) async throws -> [CategoryResponseDTO] {
        
        guard let userID = req.parameters.get("userid", as: UUID.self) else {
            throw Abort(.badRequest)
        }
        
        return try await Category.query(on: req.db)
            .filter(\.$user.$id == userID)
            .all()
            .compactMap(CategoryResponseDTO.init)
    }
}
