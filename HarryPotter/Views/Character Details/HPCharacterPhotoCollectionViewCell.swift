//
//  HPCharacterPhotoCollectionViewCell.swift
//  HarryPotter
//
//  Created by Charity Funtila on 9/1/23.
//

import UIKit

final class HPCharacterPhotoCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Properties
    
    static let identifier = "HPCharacterPhotoCollectionViewCell"
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
    
    //MARK: - Helpers
    
    private func setUpUI() {
        contentView.backgroundColor = .secondarySystemBackground
        contentView.addSubviews(imageView)
        addConstraints()
    }
    
    private func addConstraints() {
        imageView.anchor(top: contentView.topAnchor, bottom: contentView.bottomAnchor, left: contentView.leftAnchor, right: contentView.rightAnchor)
    }
    
    public func configure(with viewModel: HPCharacterPhotoCollectionViewCellViewModel) {
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
