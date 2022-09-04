//
//  RickyMortyVC.swift
//  RickyMorty
//
//  Created by Mehmet Ergün on 2022-09-03.
//

import UIKit
import SnapKit

protocol RickyMortyOutPut {
    func changeLoading(isLoad: Bool)
    func saveDatas(values: [Result])
}

final class RickyMortyVC: UIViewController {
    
    private let labelTitle = UILabel()
    private let tableView = UITableView()
    private let indicator = UIActivityIndicatorView()
    private var results: [Result] = []
    lazy var viewModel: IRickyMortyViewModel = RickyMortyViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        view.backgroundColor = .systemBackground
        viewModel.setDelegate(output: self)
        viewModel.fetchItems()
        
    }
    func configure() {
        view.addSubview(labelTitle)
        view.addSubview(tableView)
        view.addSubview(indicator)

        drawDesign()
        makeLabel()
        makeIndicator()
        makeTableView()
        
    }
    
    private func drawDesign() {
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(RickyMortyCell.self, forCellReuseIdentifier: RickyMortyCell.identifier)
        
        tableView.rowHeight = self.view.frame.size.height * 0.3
        
        DispatchQueue.main.async {
            self.indicator.color = .systemRed
            self.labelTitle.text = "Ricky Morty"
            self.labelTitle.font = .boldSystemFont(ofSize: 25)
        }
        indicator.startAnimating()
    }
}

extension RickyMortyVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: RickyMortyCell.identifier, for: indexPath) as? RickyMortyCell else {return UITableViewCell()}

        cell.saveModel(model: results[indexPath.row])
        
        return cell
    }
    
    
}

extension RickyMortyVC: RickyMortyOutPut {
    func changeLoading(isLoad: Bool) {
        isLoad ? indicator.startAnimating() : indicator.stopAnimating()
    }
    
    func saveDatas(values: [Result]) {
        results = values
        tableView.reloadData()
    }
    
    
}
extension RickyMortyVC {
    private func makeTableView() {
        tableView.snp.makeConstraints { make in
            make.top.equalTo(labelTitle.snp.bottom).offset(5)
            make.bottom.equalToSuperview()
            make.trailing.leading.equalTo(labelTitle)
        }
    }
    
    private func makeLabel() {
        labelTitle.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.height.greaterThanOrEqualTo(10)
        }
    }
    
    private func makeIndicator() {
        indicator.snp.makeConstraints { make in
            make.height.equalTo(labelTitle)
            make.trailing.equalTo(labelTitle).offset(-5)
            make.top.equalTo(labelTitle)
        }
    }
}
