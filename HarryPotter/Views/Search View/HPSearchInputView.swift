//
//  HPSearchInputView.swift
//  HarryPotter
//
//  Created by Charity Funtila on 10/3/23.
//

import UIKit

final class HPSearchInputView: UIView {
    
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Character name"
        return searchBar
    }()
    
    private var viewModel: HPSearchInputViewViewModel? {
        didSet {
            guard let viewModel = viewModel, viewModel.hasDynamicOptions else {
                return
            }
            
            let options = viewModel.options
            createOptionSelectionViews(options)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemPink
        addSubviews(searchBar)
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func addConstraints() {
        searchBar.anchor(top: topAnchor, left: leftAnchor, right: rightAnchor, height: 50)
    }
    
    private func createOptionSelectionViews(_ options: [HPSearchInputViewViewModel.DynamicOption]) {
        for option in options {
            print(option.rawValue)
        }
    }
    
    public func configure(with viewModel: HPSearchInputViewViewModel) {
        searchBar.placeholder = viewModel.searchPlaceholderText
        self.viewModel = viewModel
    }

}
