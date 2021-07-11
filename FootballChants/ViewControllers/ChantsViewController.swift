//
//  ViewController.swift
//  FootballChants
//
//  Created by Danil Lomaev on 10.07.2021.
//

import UIKit

class ChantsViewController: UIViewController {
    // MARK: - UI

    private lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.backgroundColor = .clear
        tv.rowHeight = UITableView.automaticDimension
        tv.estimatedRowHeight = 44
        tv.separatorStyle = .none
        tv.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tv.register(TeamTableViewCell.self, forCellReuseIdentifier: TeamTableViewCell.cellId)
        return tv
    }()

    private lazy var teamViewModel = TeamsViewModel()
    private lazy var audioViewModel = AudioManagerViewModel()
    private var heightCache: [String: Any] = [:]

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
    }

    override func loadView() {
        super.loadView()
        setupUI()
    }
}

// MARK: - setup UI

private extension ChantsViewController {
    func setupUI() {
        tableView.dataSource = self
        tableView.delegate = self

        navigationController?.navigationBar.topItem?.title = "Football Chants"
        navigationController?.navigationBar.prefersLargeTitles = true

        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ])
    }
}

// MARK: - UITableViewDataSource

extension ChantsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return teamViewModel.teams.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let team = teamViewModel.teams[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: TeamTableViewCell.cellId, for: indexPath) as! TeamTableViewCell
        cell.configure(with: team, delegate: self)
        return cell
    }
}

// MARK: - TeamTableViewCellDelegate

extension ChantsViewController: TeamTableViewCellDelegate {
    func didTapPlayback(for team: Team) {
        teamViewModel.togglePlayback(for: team)
        audioViewModel.playback(team)
        tableView.reloadData()
    }
}
