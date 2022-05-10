//
//  XCUIApplication+.swift
//  ReciptopiaUITests
//
//  Created by 김세영 on 2022/05/10.
//

import XCTest

extension XCUIApplication {
    
    func tapButton(_ title: String, count: Int = 1) {
        guard count > 0 else { return }
        for _ in 1...count {
            self.buttons[title].tap()
        }
    }
}
