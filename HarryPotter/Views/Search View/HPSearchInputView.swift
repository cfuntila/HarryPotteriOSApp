//
//  HPSearchInputView.swift
//  HarryPotter
//
//  Created by Charity Funtila on 10/3/23.
//

import UIKit

final class HPSearchInputView: UIView {
    
    let viewModel: HPSearchInputViewViewModel
    
    init(frame: CGRect, viewModel: HPSearchInputViewViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }

}
