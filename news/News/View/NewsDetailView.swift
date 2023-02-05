//
//  NewsDetailView.swift
//  News
//
//  Created by Нурмуханбет Сертай on 05.02.2023.
//

import UIKit
import SafariServices


class NewsDetailView: UIView {
   
    private let descriptionLabel = UILabel()
    private let imageView = UIImageView()
    private let textView = UITextView()
    private let dateLabel = UILabel()
    private let sourceLabel = UILabel()
    private let linkButton = UIButton(type: .system)


    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    

    private func setupView() {
        
        descriptionLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)

        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true

       
        textView.isEditable = false
        textView.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        
        dateLabel.font = UIFont.systemFont(ofSize: 14, weight: .light)
        
        
        sourceLabel.font = UIFont.systemFont(ofSize: 14, weight: .light)
        
        linkButton.setTitle("Read more", for: .normal)
        linkButton.addTarget(self, action: #selector(openLink), for: .touchUpInside)


        let stackView = UIStackView(arrangedSubviews: [descriptionLabel, imageView, textView, dateLabel, sourceLabel, linkButton])
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false

        addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),

            imageView.heightAnchor.constraint(equalToConstant: 200),
        ])
    }
    
    @objc private func openLink() {
        if let url = URL(string: linkButton.title(for: .normal) ?? ""), UIApplication.shared.canOpenURL(url) {
            let safariVC = SFSafariViewController(url: url)
            UIApplication.shared.keyWindow?.rootViewController?.present(safariVC, animated: true, completion: nil)
        }
    }
    
    private func setupImageView() {
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true

            addSubview(imageView)
        }

    func configure(with news: Article) {
       
        descriptionLabel.text = news.title
        textView.text = news.description
        dateLabel.text = news.publishedAt
        sourceLabel.text = news.source.name
        linkButton.setTitle(news.url, for: .normal)
        
        if let url = URL(string: news.urlToImage ?? "") {
                   imageView.loadImage(from: url)
               }
        
        
         
    }
      
}

extension UIImageView {
    func loadImage(from url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
