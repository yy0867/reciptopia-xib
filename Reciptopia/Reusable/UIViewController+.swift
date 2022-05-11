//
//  UIViewController+.swift
//  Reciptopia
//
//  Created by 김세영 on 2022/05/11.
//

import UIKit

extension UIViewController {
    
    func presentErrorAlert(
        title: String = "오류",
        reason: String = "오류가 발생했습니다. 잠시 후 다시 시도해주세요."
    ) {
        let alertController = UIAlertController(title: title, message: reason, preferredStyle: .alert)
        let okay = UIAlertAction(title: "확인", style: .default)
        
        alertController.addAction(okay)
        
        present(alertController, animated: true)
    }
}
