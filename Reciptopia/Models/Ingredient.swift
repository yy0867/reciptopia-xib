//
//  Ingredient.swift
//  ReciptopiaKit
//
//  Created by 김세영 on 2022/05/06.
//

public struct Ingredient: Codable {
    public let id: Int?
    public let name: String
    public let detail: String?
    public var isMainIngredient: Bool
    
    public init(
        id: Int? = nil,
        name: String,
        detail: String? = nil,
        isMainIngredient: Bool = false
    ) {
        self.id = id
        self.name = name
        self.detail = detail
        self.isMainIngredient = isMainIngredient
    }
}

extension Ingredient: Equatable {}
