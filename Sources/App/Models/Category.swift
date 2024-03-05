

import Foundation
import Fluent
import Vapor

final class Category: Model, Content, Validatable {
    
    static let schema: String = "categories"
    
    static func validations(_ validations: inout Vapor.Validations) {
        validations.add("title", as: String.self, is: !.empty, customFailureDescription: "Title cannot be empty")
        validations.add("color", as: String.self, is: !.empty, customFailureDescription: "Color cannot be empty")
        validations.add("password", as: String.self, is: .count(6...10), customFailureDescription: "Password must be between 6 and 10 characters long")
    }
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "title")
    var title: String
    
    @Field(key: "color")
    var color: String
    
    @Parent(key: "userid")
    var user: User
    
    init() {}
    
    init(id: UUID? = nil, title: String, color: String, userid: UUID) {
        self.id = id
        self.title = title
        self.color = color
        self.$user.id = userid
    }

}
