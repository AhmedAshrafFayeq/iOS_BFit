//
//  UIView+Extension.swift
//  BFit
//
//  Created by Ahmed Fayeq on 29/07/2022.
//

import Foundation
import UIKit

extension UIView {
    
    func addShadowToView(){
        layer.shadowColor   = UIColor.black.cgColor
        layer.shadowOffset  = .zero
        layer.cornerRadius  = 12
        layer.shadowRadius  = 10
        layer.shadowOpacity = 0.3
    }
}
