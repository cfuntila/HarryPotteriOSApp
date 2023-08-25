//
//  HPFooterLoadingCollectionReusableView.swift
//  HarryPotter
//
//  Created by Charity Funtila on 8/24/23.
//

import UIKit

final class HPFooterLoadingCollectionReusableView: UICollectionReusableView {
    static let identifier = "HPFooterLoadingCollectionReusableView"
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.hidesWhenStopped = true
        return spinner
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBrown
        addSubview(spinner)
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor),
            spinner.widthAnchor.constraint(greaterThanOrEqualToConstant: 100),
            spinner.heightAnchor.constraint(greaterThanOrEqualToConstant: 100)
        ])
    }
    
    public func startAnimating() {
        spinner.startAnimating()
    }
}
 
