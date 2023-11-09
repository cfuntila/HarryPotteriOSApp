//
//  HPCharacterFamilyMemberCollectionViewCell.swift
//  HarryPotter
//
//  Created by Charity Funtila on 9/1/23.
//

import UIKit

final class HPCharacterFamilyMemberCollectionViewCell: UICollectionViewCell {
    static let identifier = "HPCharacterFamilyMemberCollectionViewCell"
    
    private let nameLabel: UILabel = {
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
        contentView.addSubview(nameLabel)
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = nil
    }
    
    //MARK: - Helpers
    
    private func addConstraints() {
        contentView.roundCorners()
        nameLabel.roundCorners()
        
        nameLabel.anchor(top: contentView.topAnchor, bottom: contentView.bottomAnchor, left: contentView.leftAnchor, right: contentView.rightAnchor, paddingLeft: 10)
    }
    
    public func configure(with viewModel: HPCharacterFamilyMemberCollectionViewCellViewModel ) {
        self.nameLabel.text = viewModel.familyMemberString
    }
}
