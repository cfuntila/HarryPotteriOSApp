//
//  HPSpellsTableView.swift
//  HarryPotter
//
//  Created by Charity Funtila on 9/4/23.
//

import UIKit

final class HPSpellsTableView: UIView {
    //MARK: - Properties
    let viewModel = HPSpellTableViewViewModel()
    
    //MARK: - Views
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        return spinner
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.isHidden = false
        tableView.register(HPSpellTableViewCell.self, forCellReuseIdentifier: HPSpellTableViewCell.identifier)
        return tableView
    }()
    
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false

        addSubviews(tableView)
        addConstraints()
        
        
        viewModel.delegate = self
        viewModel.fetchSpells()
        
        
        setUpTableView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    //MARK: - Helpers
    
    private func addConstraints() {
        tableView.anchor(
            top: topAnchor,
            bottom: bottomAnchor,
            left: leftAnchor,
            right: rightAnchor
        )
        
//        spinner.center(inView: self)
//        spinner.setDimensions(width: 100, height: 100)
    }
    
    private func setUpTableView() {
        tableView.dataSource = viewModel
        tableView.delegate = viewModel
    }
}

extension HPSpellsTableView: HPSpellTableViewViewModelDelegate {
    func didLoadInitialSpells() {
        spinner.stopAnimating()
        tableView.isHidden = false
        tableView.reloadData()
        UIView.animate(withDuration: 0.4) {
            self.tableView.alpha = 1
        }
    }
   
}
