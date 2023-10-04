//
//  HPNoSearchResultsView.swift
//  HarryPotter
//
//  Created by Charity Funtila on 10/3/23.
//

import UIKit

class HPNoSearchResultsView: UIView {
    let viewModel = HPNoSearchResultsViewViewModel()
    
    private let iconView: UIImageView = {
        let iconView = UIImageView()
        iconView.contentMode = .scaleAspectFit
        iconView.tintColor = .systemBlue
        return iconView
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20, weight: .medium)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews(iconView, label)
        addConstraints()
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func addConstraints() {
        iconView.setDimensions(width: 90, height: 90)
        iconView.centerX(inView: self, topAnchor: topAnchor)
        
        label.anchor(top: iconView.bottomAnchor, bottom: bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 10)
        
    }
    
    private func configure() {
        label.text = viewModel.title
        iconView.image = viewModel.image
    }
}
