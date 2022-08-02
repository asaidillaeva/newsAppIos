//
//  DetailsViewController.swift
//  NewsApp
//
//  Created by Aliia Saidillaeva  on 22/7/22.
//

import Foundation
import UIKit

class DetailsViewController: UIViewController {
    
    private let dateLabel: UILabel = {
        let view = UILabel()
        view.textColor = .gray
        view.font = .systemFont(ofSize: 16)
        return view
    }()
    
    private let titleLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 0
        view.font = .systemFont(ofSize: 18, weight: .bold)
        view.text = "Title"
        return view
    }()
    
    private lazy var articlesImage: UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        return view
    }()
    
    private let authorLabel: UILabel = {
        let view = UILabel()
        view.text = "author"
        view.numberOfLines = 0
        view.font = .systemFont(ofSize: 16, weight: .regular)
        return view
    }()
    
    private let contentLabel: UILabel = {
        let view = UILabel()
        view.text = "author"
        view.numberOfLines = 0
        view.font = .systemFont(ofSize: 16, weight: .regular)
        return view
    }()
    
    private let descriptionLabel: UILabel = {
        let view = UILabel()
        view.text = "author"
        view.numberOfLines = 0
        view.font = .systemFont(ofSize: 16, weight: .regular)
        return view
    }()
    
    var model: DBArticle? {
        didSet {
            titleLabel.text = model?.title
            authorLabel.text = model?.source?.name
            dateLabel.text = model?.publishedAt
            descriptionLabel.text = model?.articleDescription
            contentLabel.text = model?.content
            articlesImage.loadFrom(model?.urlToImage ?? "")
        }
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup(){
        setupSubviews()
        setupConstraints()
    }
    
    private func setupSubviews() {
        view.backgroundColor = .white
        view.addSubview(articlesImage)
        view.addSubview(titleLabel)
        view.addSubview(authorLabel)
        view.addSubview(dateLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(contentLabel)
    }
    
    private func setupConstraints() {
        articlesImage.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(15)
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(160)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(15)
            make.top.equalTo(articlesImage.snp.bottom).offset(5)
        }
        
        authorLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(15)
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(15)
            make.top.equalTo(authorLabel.snp.bottom).offset(5)
        }
        descriptionLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(15)
            make.top.equalTo(dateLabel.snp.bottom).offset(10)
            
        }
        contentLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(15)
            make.top.equalTo(descriptionLabel.snp.bottom).offset(5)
            make.bottom.lessThanOrEqualToSuperview().inset(15)
        }
        
    }
}


