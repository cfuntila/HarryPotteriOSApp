//
//  HPSearchOptionPickerViewController.swift
//  HarryPotter
//
//  Created by Charity Funtila on 10/5/23.
//

import UIKit


/// Popup view to show options for a filter
final class HPSearchOptionPickerViewController: UIViewController {
    
    //MARK: - Private
    
    private let option: HPSearchInputViewViewModel.DynamicOption
    
    private let selectionBlock: ((String) -> Void)
    
    //MARK: - Views
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    //MARK: - Init
    
    init(option: HPSearchInputViewViewModel.DynamicOption, selection: @escaping (String) -> Void) {
        self.option = option
        self.selectionBlock = selection
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setUpTable()
    }
    
    //MARK: - Private
    
    private func setUpTable() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            bottom: view.safeAreaLayoutGuide.bottomAnchor,
            left: view.safeAreaLayoutGuide.leftAnchor,
            right: view.safeAreaLayoutGuide.rightAnchor
        )
    }
}

//MARK: - TableView Delegate

extension HPSearchOptionPickerViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = option.choices[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return option.choices.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let optionSelected = option.choices[indexPath.row]
        // bubble up optionSelected to HPSearchViewController
        self.selectionBlock(optionSelected)
        dismiss(animated: true)
    }
    
    
}
