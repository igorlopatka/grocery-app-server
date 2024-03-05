//
//  File.swift
//  
//
//  Created by Igor Łopatka on 05/03/2024.
//

import Foundation
import Vapor
import GettingThingsDoneSharedDTO

extension CategoryResponseDTO: Content {
    
    init?(_ category: Category) {
        guard let id = category.id
        else {
            return nil
        }
        self.init(id: id, title: category.title, color: category.color)
    }
}
