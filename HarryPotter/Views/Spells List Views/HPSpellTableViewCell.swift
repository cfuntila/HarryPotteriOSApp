//
//  HPSpellTableViewCell.swift
//  HarryPotter
//
//  Created by Charity Funtila on 9/4/23.
//

import UIKit

class HPSpellTableViewCell: UITableViewCell {
    
    //MARK: - Properties
    
    static let identifier = "HPSpellTableViewCell"
    
    //MARK: - Views
    private let spellImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let spellNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.sizeToFit()
        return label
    }()
    
    //MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpUI()
    }
        
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    //MARK: - Helpers
    
    private func setUpUI() {
        contentView.backgroundColor = .secondarySystemBackground
        contentView.addSubviews(spellImageView, spellNameLabel)
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
        spellImageView.anchor(top: contentView.topAnchor, left: contentView.leftAnchor, right: contentView.rightAnchor, paddingTop: 5, paddingLeft: 5, paddingRight: 5)
        spellNameLabel.anchor(top: spellImageView.bottomAnchor, bottom: contentView.bottomAnchor, left: contentView.leftAnchor, right: contentView.rightAnchor, paddingTop: 5, paddingLeft: 8, paddingBottom: 5, paddingRight: 8)
        
        NSLayoutConstraint.activate([
            spellNameLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 40)
        ])
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        setUpContentViewLayer()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        spellImageView.image = nil
        spellNameLabel.text = nil
    }
    
    public func configure(with viewModel: HPSpellTableViewCellViewModel) {
        spellNameLabel.text = viewModel.spellName
        
        viewModel.fetchImage(completion: { [weak self] result in
            switch result {
                case .failure(let error):
                    print(String(describing: error))
                    break
                case .success(let data):
                    DispatchQueue.main.async {
                        let image = UIImage(data: data)
                        self?.spellImageView.image = image
                    }
            }
        })
    }

}
