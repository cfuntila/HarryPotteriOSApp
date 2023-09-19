//
//  HPFooterLoadingCollectionReusableView.swift
//  HarryPotter
//
//  Created by Charity Funtila on 8/24/23.
//

import UIKit


/// View to show Loader when fetching more characters
final class HPFooterLoadingCollectionReusableView: UICollectionReusableView {
    
    //MARK: - Properties
    
    static let identifier = "HPFooterLoadingCollectionReusableView"
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.hidesWhenStopped = true
        return spinner
    }()
    
    //MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBrown
        addSubview(spinner)
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    //MARK: - Helpers
    
    private func addConstraints() {
        spinner.center(inView: self)
        spinner.setDimensions(width: 100, height: 100)
    }
    
    public func startAnimating() {
        spinner.startAnimating()
    }
}
 
