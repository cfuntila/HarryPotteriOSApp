//
//  HPCollectionViewCell.swift
//  HarryPotter
//
//  Created by Charity Funtila on 9/19/23.
//

import UIKit
import SwiftGifOrigin

final class HPCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Properties
    
    static let identifier = "HPCollectionViewCell"
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.sizeToFit()
        return label
    }()
    
    //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    //MARK: - Helpers
    
    private func setUpUI() {
        contentView.backgroundColor = .secondarySystemBackground
        contentView.addSubviews(imageView, nameLabel)
        addConstraints()
        setUpContentViewLayer()
    }
    
    private func setUpContentViewLayer() {
        contentView.layer.cornerRadius = 8
        contentView.layer.shadowRadius = 4
        contentView.layer.shadowOpacity = 0.3
        contentView.layer.shadowOffset = CGSize(width: -4, height: 4)
        contentView.layer.shadowColor = UIColor.secondaryLabel.cgColor
    }
    
    private func addConstraints() {
        imageView.anchor(top: contentView.topAnchor, left: contentView.leftAnchor, right: contentView.rightAnchor, paddingTop: 5, paddingLeft: 5, paddingRight: 5)
        nameLabel.anchor(top: imageView.bottomAnchor, bottom: contentView.bottomAnchor, left: contentView.leftAnchor, right: contentView.rightAnchor, paddingTop: 5, paddingLeft: 8, paddingBottom: 5, paddingRight: 8)
        
        NSLayoutConstraint.activate([
            nameLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 40)
        ])
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        setUpContentViewLayer()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        nameLabel.text = nil
    }
    
    public func configure(with viewModel: HPCollectionViewCellViewModel) {
        nameLabel.text = viewModel.name
        
        viewModel.fetchImage(completion: { [weak self] result in
            switch result {
                case .failure(let error):
                    print(String(describing: error))
                    break
                case .success(let data):
                    DispatchQueue.main.async {
                            // Check if the data is a GIF.
                        let isGif = viewModel.imageString?.lowercased().hasSuffix(".gif") ?? false

                        if isGif {
                            // Use SwiftGif to display the GIF.
                            self?.imageView.image = UIImage.gif(data: data)
                        } else {
                            // Use the regular UIImage for non-GIF images.
                            self?.imageView.image = UIImage(data: data)
                        }
                    }
            }
        })
    }
}

