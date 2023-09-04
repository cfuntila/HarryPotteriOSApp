//
//  HPCharacterInfoCollectionViewCell.swift
//  HarryPotter
//
//  Created by Charity Funtila on 9/1/23.
//

import UIKit

final class HPCharacterInfoCollectionViewCell: UICollectionViewCell {
    //MARK: - Properties
    
    static let identifier = "HPCharacterInfoCollectionViewCell"
    
    //MARK: - Subviews
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .medium )
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.backgroundColor = UIColor(named: "Gryffindor")
        label.textAlignment = .center
        label.sizeToFit()
        label.setDimensions(width: 100, height: 50)
        return label
    }()
    
    private let valueLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .medium )
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.sizeToFit()
        return label
    }()
    
    private let infoView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        return stackView
    }()

    
    //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews(infoView)
        infoView.addSubviews(titleLabel, valueLabel)
        setUpContentViewLayer()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    //MARK: - Helpers
    
    private func setUpContentViewLayer() {
        contentView.layer.cornerRadius = 10
        contentView.layer.shadowRadius = 4
        contentView.layer.shadowOpacity = 0.3
        contentView.layer.shadowOffset = CGSize(width: -4, height: 4)
        contentView.layer.shadowColor = UIColor.secondaryLabel.cgColor
    }
    
    private func addConstraints() {
        infoView.anchor(
            top: topAnchor,
            bottom: bottomAnchor,
            left: leftAnchor,
            right: rightAnchor
        )
        
        titleLabel.anchor(
            top: infoView.topAnchor,
            bottom: valueLabel.topAnchor,
            left: infoView.leftAnchor,
            right: infoView.rightAnchor,
            paddingTop: 0,
            paddingLeft: 0,
            paddingBottom: 0,
            paddingRight: 0
        )

        valueLabel.anchor(
            top: titleLabel.bottomAnchor,
            bottom: infoView.bottomAnchor,
            left: infoView.leftAnchor,
            right: infoView.rightAnchor,
            paddingTop: 10,
            paddingLeft: 10,
            paddingBottom: 10,
            paddingRight: 10
        )
        
        
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        setUpContentViewLayer()
    }
    
    public func configure(with viewModel: HPCharacterInfoCollectionViewCellViewModel) {
        self.titleLabel.text = viewModel.title
        self.valueLabel.text = viewModel.value
    }
}
