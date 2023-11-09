//
//  HPSearchInputView.swift
//  HarryPotter
//
//  Created by Charity Funtila on 10/3/23.
//

import UIKit

protocol HPSearchInputViewDelegate: AnyObject {
    func hpSearchInputView(_ inputView: HPSearchInputView,
                           didSelectOption option: HPSearchInputViewViewModel.DynamicOption)
}

final class HPSearchInputView: UIView {
    
    public weak var delegate: HPSearchInputViewDelegate?
    
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
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        stackView.alignment = .center
        addSubview(stackView)
        
        stackView.anchor(top: searchBar.bottomAnchor, bottom: bottomAnchor, left: leftAnchor, right: rightAnchor)
        stackView.backgroundColor = .ravenclawBlue
        
        for i in 0..<options.count {
            let option = options[i]
            let button = UIButton()
            button.setTitle(option.rawValue, for: .normal)
            button.backgroundColor = .hogwartsGrey
            button.setTitleColor(.gryffindorRed, for: .normal)
            button.tag = i
            button.addTarget(self, action: #selector(didTapFilterButton(_:)), for: .touchUpInside)
            
            stackView.addArrangedSubview(button)
        }
    }
    
    @objc
    private func didTapFilterButton(_ sender: UIButton) {
        guard let options = viewModel?.options else {
            return
        }
        
        let tag = sender.tag
        let selected = options[tag]
        delegate?.hpSearchInputView(self, didSelectOption: selected )        
    }
    
    public func configure(with viewModel: HPSearchInputViewViewModel) {
        searchBar.placeholder = viewModel.searchPlaceholderText
        self.viewModel = viewModel
    }
    
    public func presentKeyboard() {
        searchBar.becomeFirstResponder() 
    }

}
