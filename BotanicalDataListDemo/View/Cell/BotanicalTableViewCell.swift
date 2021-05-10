//
//  BotanicalTableViewCell.swift
//  BotanicalDataListDemo
//
//  Created by Joshua Chang on 2021/5/9.
//  Copyright © 2021 Joshua Chang. All rights reserved.
//

import UIKit
import Kingfisher

final class BotanicalTableViewCell: UITableViewCell {
    
    // MARK: - Property
    private lazy var img: UIImageView = {
        let image = UIImageView(frame: .zero)
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var nameView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .systemGreen
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var locationView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .systemBlue
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var featureView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .systemOrange
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var containerStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [nameView, locationView, featureView])
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 1
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(nameView)
        stackView.addArrangedSubview(locationView)
        stackView.addArrangedSubview(featureView)
        let nameIndex = 0
        if
            nameIndex >= stackView.arrangedSubviews.startIndex,
            nameIndex < stackView.arrangedSubviews.endIndex {
            stackView.arrangedSubviews[nameIndex].snp.makeConstraints {
                $0.height.equalTo(44).priority(.medium)
            }
        }
        let locationIndex = 1
        if
            locationIndex >= stackView.arrangedSubviews.startIndex,
            locationIndex < stackView.arrangedSubviews.endIndex {
            stackView.arrangedSubviews[locationIndex].snp.makeConstraints {
                $0.height.equalTo(44).priority(.medium)
            }
        }
        let featureIndex = 2
        if
            featureIndex >= stackView.arrangedSubviews.startIndex,
            featureIndex < stackView.arrangedSubviews.endIndex {
            stackView.arrangedSubviews[featureIndex].snp.makeConstraints {
                $0.height.equalTo(100).priority(.medium)
            }
        }
        return stackView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.backgroundColor = .clear
        label.textAlignment = .left
        label.textColor = .black
        label.font = UIFont(name: "PingFangTC-Regular", size: 14)
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var locationLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.backgroundColor = .clear
        label.textAlignment = .left
        label.textColor = .black
        label.font = UIFont(name: "PingFangTC-Regular", size: 14)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var featureTextView: UITextView = {
        let textView = UITextView(frame: .zero)
        textView.backgroundColor = .clear
        textView.textAlignment = .justified
        textView.textColor = .black
        textView.font = UIFont(name: "PingFangTC-Regular", size: 14)
        textView.autocapitalizationType = .allCharacters
        textView.isEditable = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    // MARK: - Initialize
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.layoutConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Reusable
    override func prepareForReuse() {
        super.prepareForReuse()
        isHidden = false
        isSelected = false
        isHighlighted = false
        self.img.image = nil
        self.nameLabel.text = nil
        self.locationLabel.text = nil
        self.featureTextView.text = nil
    }
    
    func setup(_ cellViewModel: CellViewModel) {
        if let url = cellViewModel.fPic01URL {
            let imgManager = ImageDownloader.default
            imgManager.trustedHosts = Set(["www.zoo.gov.tw"])
            KingfisherManager.shared.downloader = imgManager
            DispatchQueue.main.async {
                self.img.kf.setImage(with: URL(string: url))
            }
        }
        
        if let name = cellViewModel.fNameCh {
            DispatchQueue.main.async {
                self.nameLabel.text = name
            }
        }
        
        if let location = cellViewModel.fLocation {
            DispatchQueue.main.async {
                self.locationLabel.text = location
            }
        }
        
        if let feature = cellViewModel.fFeature {
            DispatchQueue.main.async {
                self.featureTextView.text = feature
            }
        }
    }

}

private extension BotanicalTableViewCell {
    
    private func layoutConstraints() {
        self.selectionStyle = .none
        self.setupImg()
        self.setupContainView()
        self.setupName()
        self.setupLocation()
        self.setupFeature()
    }
    
    private func setupImg() {
        self.contentView.addSubview(self.img)
        img.snp.makeConstraints {
            $0.leading.top.equalToSuperview().inset(10)
            $0.height.width.equalTo(80)
        }
    }
    
    private func setupContainView() {
        self.contentView.addSubview(self.containerStackView)
        containerStackView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(100)
            $0.top.trailing.bottom.equalToSuperview().inset(10)
            $0.height.equalToSuperview().priority(.low)
        }
    }
    
    private func setupName() {
        self.nameView.addSubview(self.nameLabel)
        nameLabel.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func setupLocation() {
        self.locationView.addSubview(self.locationLabel)
        locationLabel.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func setupFeature() {
        self.featureView.addSubview(self.featureTextView)
        featureTextView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
