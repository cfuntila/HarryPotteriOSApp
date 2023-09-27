//
//  HPInfoCollectionViewCell.swift
//  HarryPotter
//
//  Created by Charity Funtila on 9/1/23.
//

import UIKit

final class HPInfoCollectionViewCell: UICollectionViewCell {
    //MARK: - Properties
    
    static let identifier = "HPInfoCollectionViewCell"
    
    //MARK: - Subviews
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .medium )
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.backgroundColor = UIColor(named: "Gryffindor")
        label.textAlignment = .center
        label.sizeToFit()
        return label
    }()
    
    private let titleContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .tertiarySystemBackground
        view.roundCorners()
        view.clipsToBounds = true
        return view
    }()
    
    private let valueLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .medium )
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.sizeToFit()
        return label
    }()
    
    //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.roundCorners()
        contentView.addSubviews(titleContainer, valueLabel)
        titleContainer.addSubview(titleLabel)
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        valueLabel.text = nil
    }
    
    //MARK: - Helpers
    
    private func addConstraints() {
        titleContainer.setDimensions(width: contentView.frame.width, height: 50)
        titleContainer.anchor(
            top: contentView.topAnchor,
            left: contentView.leftAnchor,
            right: contentView.rightAnchor
        )
        
        titleLabel.anchor(
            top: titleContainer.topAnchor,
            bottom: titleContainer.bottomAnchor,
            left: titleContainer.leftAnchor,
            right: titleContainer.rightAnchor,
            paddingTop: 0,
            paddingLeft: 0,
            paddingBottom: 0,
            paddingRight: 0
        )

        valueLabel.anchor(
            top: titleContainer.bottomAnchor,
            bottom: contentView.bottomAnchor,
            left: contentView.leftAnchor,
            right: contentView.rightAnchor,
            paddingTop: 10,
            paddingLeft: 10,
            paddingBottom: 10,
            paddingRight: 10
        )
    }
    
    public func configure(with viewModel: HPInfoCollectionViewCellViewModel) {
        self.titleLabel.text = viewModel.title
        self.valueLabel.text = viewModel.value
    }
}
