//
//  Extentions.swift
//  HarryPotter
//
//  Created by Charity Funtila on 8/21/23.
//

import UIKit


extension UIView {
    func addSubviews(_ views: UIView...) {
        for view in views {
            self.addSubview(view)
        }
    }
}
