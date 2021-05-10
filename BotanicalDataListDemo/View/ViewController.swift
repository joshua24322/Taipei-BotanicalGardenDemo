//
//  ViewController.swift
//  BotanicalDataListDemo
//
//  Created by Joshua Chang on 2021/5/8.
//  Copyright © 2021 Joshua Chang. All rights reserved.
//

import UIKit
import SnapKit

final class ViewController: UIViewController {
    
    private lazy var topLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.backgroundColor = .systemGreen
        label.text = "Test"
        label.textColor = .white
        label.textAlignment = .center
        label.alpha = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .singleLine
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.register(BotanicalTableViewCell.self, forCellReuseIdentifier: "\(BotanicalTableViewCell.self)")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private(set) var viewModel: ViewModel?
    
    override func loadView() {
        super.loadView()
        self.layoutConstraints()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.setupBinding()
    }
    
    private func setupBinding() {
        self.viewModel = ViewModel()
        self.viewModel?.invokeDataList { [weak self] in
            guard let weakSelf = self else { return }
            DispatchQueue.main.async {
                weakSelf.tableView.reloadData()
            }
        }
    }

}

private extension ViewController {
    
    private func layoutConstraints() {
        self.setupNavBar()
        self.setupTableView()
        self.setupTopLabel()
    }
    
    private func setupNavBar() {
        self.navigationItem.title = "Test"
    }
    
    private func setupTableView() {
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
            $0.leading.trailing.equalToSuperview()
        }
    }
    
    private func setupTopLabel() {
        self.view.addSubview(topLabel)
        topLabel.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            $0.height.equalTo(1)
            $0.leading.trailing.equalToSuperview()
        }
    }
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = self.viewModel?.cellViewModel?.count else { return 0 }
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "\(BotanicalTableViewCell.self)", for: indexPath) as? BotanicalTableViewCell,
            let cellViewModel = self.viewModel?.cellViewModel?[indexPath.row]
            else { return UITableViewCell() }
        cell.setup(cellViewModel)
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset: CGFloat = scrollView.contentOffset.y
        let alpha: CGFloat = 1 - (offset / .topLabelHeight)
        self.navigationController?.navigationBar.alpha = alpha
        UIView.animate(withDuration: 0.1, animations: { [weak self] in
            guard let weakSelf = self else { return }
            weakSelf.tableView.contentInset = UIEdgeInsets(top: offset > .topLabelHeight ? .topLabelHeight : 0, left: 0, bottom: 0, right: 0)
            weakSelf.topLabel.alpha = offset > .topLabelHeight ? -alpha : 0
            weakSelf.topLabel.snp.remakeConstraints {
                $0.top.equalTo(weakSelf.view.safeAreaLayoutGuide.snp.top)
                $0.leading.trailing.equalToSuperview()
                $0.height.equalTo(offset > .topLabelHeight ? CGFloat.topLabelHeight : 1)
            }
        }, completion: nil)
    }
    
}

extension ViewController: UITableViewDelegate {}

extension CGFloat {
    fileprivate static var topLabelHeight: CGFloat = 50.0
}
