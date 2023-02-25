//
//  HeroDetail.swift
//  Practica_ios_Avanzado
//
//  Created by Enrique Poyato Ortiz on 14/2/23.
//

import Foundation
import UIKit

class HeroDetailView: UIView {
    
    let heroeImageVIew: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = imageView.frame.size.width / 2
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let heroeName: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let heroeDescription: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = label.font.withSize(12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        
        backgroundColor = .white
        
        addSubview(heroeImageVIew)
        addSubview(heroeName)
        
        addSubview(scrollView)
        scrollView.addSubview(heroeDescription)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            heroeImageVIew.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            heroeImageVIew.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            heroeImageVIew.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            heroeImageVIew.heightAnchor.constraint(equalToConstant: 250),

            heroeName.topAnchor.constraint(equalTo: heroeImageVIew.bottomAnchor, constant: 20),
            heroeName.leadingAnchor.constraint(equalTo: heroeImageVIew.leadingAnchor),
            heroeName.trailingAnchor.constraint(equalTo: heroeImageVIew.trailingAnchor),

            heroeDescription.leadingAnchor.constraint(equalTo: heroeName.leadingAnchor),
            heroeDescription.trailingAnchor.constraint(equalTo: heroeName.trailingAnchor),
            heroeDescription.topAnchor.constraint(equalTo: heroeName.bottomAnchor, constant: 8)
        ])
    }
    
     // MARK: - Configure
    
    func configure(_ model: Hero) {
        self.heroeName.text = model.name
        self.heroeDescription.text = model.heroeDescription
        self.heroeImageVIew.kf.setImage(with: URL(string: model.photo))
    }
    
}
