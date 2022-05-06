//
//  PictureIngredientRepositoryProtocol.swift
//  ReciptopiaKit
//
//  Created by 김세영 on 2022/05/06.
//

import Foundation
import RxSwift

internal protocol PictureIngredientRepositoryProtocol {
    func analyze(_ pictures: [Data]) -> Observable<[String]>
}
