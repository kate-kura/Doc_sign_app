//
//  HomeViewController.swift
//  Doc_sign_app
//
//  Created by Екатерина on 18.03.2024.
//

import UIKit

protocol HomeViewControllerDelegate: AnyObject {
    func didTapMenuButton()
}

class HomeViewController: UIViewController {
    
    weak var delegate: HomeViewControllerDelegate?
    
    let sideButton = CustomSideButton()
    let searchTextField = CustomTextField()
    let logoImageView = UIImageView()
    let primaryLabel = UILabel()
    let secondaryLabel = UILabel()
    let tableView = UITableView()
    let addButton = CustomAddButton()
    
    // Model
    var data: [Contract] = []
    
    var filteredData: [Contract] = []
    var filtered = false

    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addViews()
        layoutViews()
        configure()
        
        tableView.delegate = self
        tableView.dataSource = self
        searchTextField.delegate = self
        
        data = DatabaseManager.shared.fetchContracts()
        updateUI()
        
        navigationController?.navigationBar.backgroundColor = Resources.Colors.background
        navigationController?.additionalSafeAreaInsets.top = 12
            
        sideButton.addTarget(self, action: #selector(didTapMenuButton), for: .touchUpInside)
        addButton.addTarget(self, action: #selector(didTapQRCodeButton), for: .touchUpInside)
    }
}

extension HomeViewController {

    // MARK: - UI Setup
    func addViews() {
        view.addSubview(sideButton)
        view.addSubview(searchTextField)
        
        view.addSubview(logoImageView)
        view.addSubview(secondaryLabel)
        view.addSubview(primaryLabel)
        view.addSubview(tableView)
        
        view.addSubview(addButton)

    }

    func layoutViews() {
        NSLayoutConstraint.activate([
            
            sideButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            sideButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 24),
            sideButton.heightAnchor.constraint(equalToConstant: 40),
            sideButton.widthAnchor.constraint(equalToConstant: 36),
            
            searchTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            searchTextField.leadingAnchor.constraint(equalTo: sideButton.trailingAnchor, constant: 8),
            searchTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -24),
            searchTextField.heightAnchor.constraint(equalToConstant: 40),
            searchTextField.widthAnchor.constraint(equalToConstant: 312),

            logoImageView.widthAnchor.constraint(equalToConstant: 100),
            logoImageView.heightAnchor.constraint(equalToConstant: 100),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),

            secondaryLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            secondaryLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 16),
            secondaryLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40),
            secondaryLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -40),

            primaryLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            primaryLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            tableView.topAnchor.constraint(equalTo: primaryLabel.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            
            addButton.widthAnchor.constraint(equalToConstant: 56),
            addButton.heightAnchor.constraint(equalToConstant: 56),
            addButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            addButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -24),
            
        ])

    }

    func configure() {
        view.backgroundColor = Resources.Colors.background

        sideButton.translatesAutoresizingMaskIntoConstraints = false
        searchTextField.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        secondaryLabel.translatesAutoresizingMaskIntoConstraints = false
        primaryLabel.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        addButton.translatesAutoresizingMaskIntoConstraints = false

        searchTextField.placeholder = Resources.Strings.search
        searchTextField.keyboardType = .default
        searchTextField.textColor = Resources.Colors.secondaryLabelColor
        searchTextField.autocapitalizationType = .sentences
        
        let textFieldContainerView = UIView(frame: CGRect(x: 0, y: 0, width: 312, height: 40))
        textFieldContainerView.addSubview(searchTextField)
        searchTextField.center = textFieldContainerView.center
        let sideButtonItem = UIBarButtonItem(customView: sideButton)
        let searchTextFieldItem = UIBarButtonItem(customView: textFieldContainerView)
        let fixedSpaceItem = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        let leftItems = [sideButtonItem, fixedSpaceItem]
        let rightItems = [searchTextFieldItem]

        self.navigationItem.leftBarButtonItems = leftItems
        self.navigationItem.rightBarButtonItems = rightItems

        logoImageView.image = Resources.Images.logo
        logoImageView.layer.cornerRadius = 16
        logoImageView.clipsToBounds = true

        secondaryLabel.textColor = Resources.Colors.secondaryLabelColor
        secondaryLabel.text = Resources.Strings.secondaryText4
        secondaryLabel.textAlignment = .center
        secondaryLabel.font = Resources.Fonts.helveticaRegular(with: 16)
        secondaryLabel.numberOfLines = 2
        secondaryLabel.sizeToFit()
        
        primaryLabel.textColor = Resources.Colors.primaryLabelColor
        primaryLabel.text = Resources.Strings.homeVCTitle
        primaryLabel.textAlignment = .center
        primaryLabel.font = Resources.Fonts.helveticaRegular(with: 22)
        primaryLabel.numberOfLines = 1
        primaryLabel.sizeToFit()

        tableView.backgroundColor = Resources.Colors.background
        tableView.register(CustomCell.self, forCellReuseIdentifier: "CustomCellIdentifier")
        tableView.separatorColor = .clear
    }
    
    // check is data empty and update UI
    func updateUI() {
        if data.isEmpty {
            logoImageView.isHidden = false
            secondaryLabel.isHidden = false
            primaryLabel.isHidden = true
            tableView.isHidden = true
        } else {
            logoImageView.isHidden = true
            secondaryLabel.isHidden = true
            primaryLabel.isHidden = false
            tableView.isHidden = false
        }
    }

    // MARK: - Selectors
    @objc func didTapMenuButton() {
        delegate?.didTapMenuButton()
    }
    
    @objc func didTapQRCodeButton() {
        let vc = QRcodeViewController()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }

}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    // return number of rows in section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !filteredData.isEmpty {
            return filteredData.count
        }
        return filtered ? 0 : data.count
    }
    
    // cell setup
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCellIdentifier", for: indexPath) as! CustomCell
    
        if !filteredData.isEmpty {
            let item = filteredData[indexPath.row]
            cell.titleLabel.text = item.title
            cell.companyLabel.text = item.companyName
            cell.actionButton.tag = indexPath.row
            cell.actionButton.addTarget(self, action: #selector(cellButtonTapped(_:)), for: .touchUpInside)
        } else {
            let item = data[indexPath.row]
            cell.titleLabel.text = item.title
            cell.companyLabel.text = item.companyName
            cell.actionButton.tag = indexPath.row
            cell.actionButton.addTarget(self, action: #selector(cellButtonTapped(_:)), for: .touchUpInside)
        }
    
        return cell
    }
    
    // MARK: - Selector
    @objc func cellButtonTapped(_ sender: UIButton) {
        let vc = BottomMenuViewController()
        
        let indexPath = IndexPath(row: sender.tag, section: 0)
 
        if !filteredData.isEmpty {
            vc.id = filteredData[indexPath.row].id
            vc.contractTitle = filteredData[indexPath.row].title
        } else {
            vc.id = data[indexPath.row].id
            vc.contractTitle = data[indexPath.row].title
        }
        
        if let sheet = vc.sheetPresentationController{
            sheet.detents = [.medium(), .large()]
            sheet.preferredCornerRadius = 16
        }
        present(vc, animated: true)
    }
    
    // cancel row selection
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }
    
    // ruturn row height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 152
    }
}

// MARK: - UITextFieldDelegate
extension HomeViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text {
            filterText(text+string)
        }
        
        return true
    }
    
    // adds data items to filteredData that begin with a query
    func filterText(_ query: String) {
        if query.isEmpty {
            filteredData = data
        } else {
            filteredData.removeAll()
            for string in data {
                if string.title!.lowercased().starts(with: query.lowercased()) {
                    filteredData.append(string)
                }
            }
        }
        
        tableView.reloadData()
        filtered = true
    }
    
    // hide keyboard with return button
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
