//
//  HPCharacterCollectionViewCell.swift
//  HarryPotter
//
//  Created by Charity Funtila on 8/21/23.
//

import UIKit


/// Cell to show character image and name
final class HPCharacterCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Properties
    
    static let identifier = "HPCharacterCollectionViewCell"
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .medium )
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
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
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            imageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 5),
            imageView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -5),
            
            nameLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 40),
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 5),
            nameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 8),
            nameLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -8),
            nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5)
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
    
    public func configure(with viewModel: HPCharacterCollectionViewCellViewModel) {
        nameLabel.text = viewModel.characterName
        viewModel.fetchImage(completion: { [weak self] result in
            switch result {
                case .failure(let error):
                    print(String(describing: error))
                    break
                case .success(let data):
                    DispatchQueue.main.async {
                        let image = UIImage(data: data)
                        self?.imageView.image = image
                    }
            }
        })
    }
}




