//
//  HPSearchView.swift
//  HarryPotter
//
//  Created by Charity Funtila on 10/3/23.
//

import UIKit

protocol HPSearchViewDelegate: AnyObject {
    func hpSearchView(_ searchView: HPSearchView, didSelectOption option: HPSearchInputViewViewModel.DynamicOption)
}

final class HPSearchView: UIView {
    
    public weak var delegate: HPSearchViewDelegate?
    
    let viewModel: HPSearchViewViewModel
    
    //MARK: - Subviews
    
    // SearchInputView (bar, selection buttons)
    
    private let searchInputView = HPSearchInputView()
    
    // NoResultsView
    
    private let noResultsView = HPNoSearchResultsView()
    
    // ResultsCollectionView
    
    //MARK: - Init
    
    init(frame: CGRect, viewModel: HPSearchViewViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
        backgroundColor = .systemBackground
        addSubviews(searchInputView, noResultsView)
        addConstraints()
        searchInputView.delegate = self
        searchInputView.configure(with:  .init(type: viewModel.config.type))
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func addConstraints() {
        searchInputView.anchor(top: topAnchor, left: leftAnchor, right: rightAnchor, height: viewModel.config.type == .spell ? 50  : 100)
        noResultsView.setDimensions(width: 150, height: 150)
        noResultsView.center(inView: self)
    }
    
    public func presentKeyboard() {
        searchInputView.presentKeyboard() 
    }
    
}

extension HPSearchView: HPSearchInputViewDelegate {
    func hpSearchInputView(_ inputView: HPSearchInputView, didSelectOption option: HPSearchInputViewViewModel.DynamicOption) {
        delegate?.hpSearchView(self, didSelectOption: option)
    }
}

//MARK: - CollectionView

extension HPSearchView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        return cell
    }
    
    
}
