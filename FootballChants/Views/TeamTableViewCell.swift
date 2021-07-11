//
//  TeamTableViewCell.swift
//  FootballChants
//
//  Created by Danil Lomaev on 11.07.2021.
//

import UIKit

class TeamTableViewCell: UITableViewCell {
    static let cellId = "TeamTableViewCell"

    // MARK: - UI

    private lazy var containerView: UIView = {
        let vw = UIView()
        vw.translatesAutoresizingMaskIntoConstraints = false
        return vw
    }()

    private lazy var badgeImageView: UIImageView = {
        let imgVw = UIImageView()
        imgVw.translatesAutoresizingMaskIntoConstraints = false
        imgVw.contentMode = .scaleAspectFit
        return imgVw
    }()

    private lazy var playbackBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.tintColor = .white
        return btn
    }()

    private lazy var contentStackView: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.spacing = 4
        sv.axis = .vertical
        return sv
    }()

    private lazy var nameLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 0
        lbl.font = .systemFont(ofSize: 18, weight: .bold)
        lbl.textColor = .white
        return lbl
    }()

    private lazy var foundedLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 0
        lbl.font = .systemFont(ofSize: 12, weight: .light)
        lbl.textColor = .white
        return lbl
    }()

    private lazy var managerLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 0
        lbl.font = .systemFont(ofSize: 10, weight: .light)
        lbl.textColor = .white
        return lbl
    }()

    private lazy var infoLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 0
        lbl.font = .systemFont(ofSize: 12, weight: .medium)
        lbl.textColor = .white
        return lbl
    }()

    private weak var delegate: TeamTableViewCellDelegate?
    private var team: Team?

    // MARK: - lifecycle

    override func layoutSubviews() {
        super.layoutSubviews()
        containerView.layer.cornerRadius = 10
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        team = nil
        delegate = nil
        contentView.subviews.forEach { $0.removeFromSuperview() }
    }

    // MARK: - configure

    func configure(with item: Team, delegate: TeamTableViewCellDelegate) {
        self.delegate = delegate
        team = item

        playbackBtn.addTarget(self, action: #selector(didTapPlayback), for: .touchUpInside)

        containerView.backgroundColor = item.id.background

        badgeImageView.image = item.id.badge
        playbackBtn.setImage(item.isPlaying ? Assets.pause : Assets.play, for: .normal)
        nameLabel.text = item.name
        foundedLabel.text = item.founded
        managerLabel.text = "Current \(item.manager.job.rawValue): \(item.manager.name)"
        infoLabel.text = item.info

        setupUI()
    }

    // MARK: - setup UI

    func setupUI() {
        contentView.addSubview(containerView)

        containerView.addSubview(badgeImageView)
        containerView.addSubview(playbackBtn)
        containerView.addSubview(contentStackView)

        contentStackView.addArrangedSubview(nameLabel)
        contentStackView.addArrangedSubview(foundedLabel)
        contentStackView.addArrangedSubview(managerLabel)
        contentStackView.addArrangedSubview(infoLabel)

        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),

            badgeImageView.heightAnchor.constraint(equalToConstant: 50),
            badgeImageView.widthAnchor.constraint(equalToConstant: 50),
            badgeImageView.topAnchor.constraint(equalTo: contentStackView.topAnchor),
            badgeImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),

            contentStackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            contentStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16),
            contentStackView.leadingAnchor.constraint(equalTo: badgeImageView.trailingAnchor, constant: 8),
            contentStackView.trailingAnchor.constraint(equalTo: playbackBtn.leadingAnchor, constant: -8),

            playbackBtn.heightAnchor.constraint(equalToConstant: 44),
            playbackBtn.widthAnchor.constraint(equalToConstant: 44),
            playbackBtn.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),
            playbackBtn.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),

        ])
    }

    // MARK: - didTapPlayback

    @objc func didTapPlayback() {
        guard let team = team else { return }
        delegate?.didTapPlayback(for: team)
    }
}
