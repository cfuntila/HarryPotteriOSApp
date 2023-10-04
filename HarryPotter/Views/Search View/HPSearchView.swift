//
//  HPSearchView.swift
//  HarryPotter
//
//  Created by Charity Funtila on 10/3/23.
//

import UIKit

final class HPSearchView: UIView {
    
    let viewModel: HPSearchViewViewModel
    
    //MARK: - Subviews
    
    // SearchInputView (bar, selection buttons)
    
    // NoResultsView
    
    private let noResultsView = HPNoSearchResultsView()
    
    // ResultsCollectionView
    
    //MARK: - Init
    
    init(frame: CGRect, viewModel: HPSearchViewViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
        backgroundColor = .systemBackground
        addSubviews(noResultsView)
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func addConstraints() {
        noResultsView.setDimensions(width: 150, height: 150)
        noResultsView.center(inView: self)
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
