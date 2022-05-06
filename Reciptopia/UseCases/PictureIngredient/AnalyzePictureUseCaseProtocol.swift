//
//  AnalyzePictureUseCaseProtocol.swift
//  ReciptopiaKit
//
//  Created by 김세영 on 2022/05/06.
//

import RxSwift
import Foundation

protocol AnalyzePictureUseCaseProtocol {
    func execute(_ pictures: [Data]) -> Observable<[String]>
}
