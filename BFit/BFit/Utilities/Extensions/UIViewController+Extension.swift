//
//  UIViewController+Extension.swift
//  BFit
//
//  Created by Ahmed Fayeq on 30/07/2022.
//

import Foundation
import UIKit
import ProgressHUD

extension UIViewController {
    func showLoading() {
        ProgressHUD.colorAnimation = .appThemeColor()
        ProgressHUD.colorProgress = .appThemeColor()
        ProgressHUD.show()
    }
    
    func hideLoading() {
        ProgressHUD.showSucceed()
        ProgressHUD.dismiss()
    }
}
