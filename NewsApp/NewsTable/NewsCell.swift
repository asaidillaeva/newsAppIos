//
//  ArticlesCell.swift
//  ArticlesApp
//
//  Created by Aliia Saidillaeva  on 11/7/22.
//

import UIKit
import SnapKit
import Kingfisher

class ArticlesCell: UITableViewCell {
    
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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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
        contentView.addSubview(articlesImage)
        contentView.addSubview(titleLabel)
        contentView.addSubview(authorLabel)
    }
    
    private func setupConstraints() {
        articlesImage.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview().inset(15)
            make.height.equalTo(160)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(15)
            make.top.equalTo(articlesImage.snp.bottom).offset(5)
        }
        
        authorLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(15)
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.bottom.equalToSuperview().inset(10)
        }
    }
    
    func setData(article: DBArticle) {
        titleLabel.text = article.title
        authorLabel.text = article.source?.name
        articlesImage.loadFrom(article.urlToImage!)
        
    }
}
extension UIImageView {
    func loadFrom(_ urlToImage: String) {
        let cache = ImageCache.default
        if cache.isCached(forKey: urlToImage) {
            cache.retrieveImage(forKey: urlToImage) { result in
                switch result {
                case .success(let value):
                    print(value.cacheType)
                    self.image = value.image
                case .failure(let error):
                    print(error)
                }
            }
        } else {
            self.kf.setImage(with: URL(string: urlToImage))
        }
    }
}
extension UITableViewCell {
    
    var identifier: String {
        .init(describing: self)
    }
    
    static var identifier: String {
        .init(describing: self)
    }
}
