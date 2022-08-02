//
//  ViewController.swift
//  ArticlesApp
//
//  Created by Aliia Saidillaeva  on 11/7/22.
//

import UIKit
import SnapKit

class ArticlesViewController: UIViewController {

    private lazy var searchController: UISearchController = {
        let controller = UISearchController()
        controller.searchBar.backgroundColor = .systemBrown
        controller.obscuresBackgroundDuringPresentation = false
        controller.searchBar.placeholder = "Найти новость"
        return controller
    }()
    
    private let tableView: UITableView = {
        let view = UITableView()
        view.register(ArticlesCell.self, forCellReuseIdentifier: ArticlesCell.identifier )
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let viewModel: IArticlesViewModel
    
    init(vm: IArticlesViewModel = ArticlesViewModel()) {
        viewModel = vm
        viewModel.monitorNetwork()
        super.init(nibName: nil, bundle: nil)
        tableView.delegate = self
        tableView.dataSource = self

        
        viewModel.getAllData { response in
            switch response {
            case .success(let data):
                if (data.count != 0) {
                self.tableView.reloadData()
                }
                break
            case .failure(let error):
                self.showError(error)
                break
            }
        }
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    private func showError(_ error: Error) {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        alert.view.backgroundColor = .black
        alert.view.alpha = 0.5
        alert.view.layer.cornerRadius = 15
        present(alert, animated: true)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            alert.dismiss(animated: true)
        }
    }
    
    private func setup() {
        navigationController?.navigationItem.searchController = searchController
        
        setupSubviews()
        setupConstraints()
    }
    
    private func setupSubviews() {
        view.addSubview(tableView)
        navigationController?.navigationItem.rightBarButtonItem = .init(image: .init(systemName: "filter"),
                                                                       style: .plain,
                                                                       target: self,
                                                                       action: #selector(rightTapped))
        
    }
    
    @objc func rightTapped() {
        
    }
    
    private func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension ArticlesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = DetailsViewController()
        vc.model = viewModel.data[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension ArticlesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ArticlesCell.identifier, for: indexPath) as! ArticlesCell
        cell.setData(article: viewModel.data[indexPath.row])
        print(viewModel.data.count)
        return cell
    }
}
