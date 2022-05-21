//
//  FeedbackGenerator.swift
//  Reciptopia
//
//  Created by 김세영 on 2022/05/21.
//

import Foundation
import UIKit

class FeedbackGenerator {
    
    static let shared = FeedbackGenerator()
    private init() {}
    
    func execute() {
        let generator = UIImpactFeedbackGenerator()
        generator.impactOccurred()
    }
}
