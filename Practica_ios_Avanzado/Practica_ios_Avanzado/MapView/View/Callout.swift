//
//  Callout.swift
//  Practica_ios_Avanzado
//
//  Created by Enrique Poyato Ortiz on 14/2/23.
//

import UIKit
import Kingfisher

class Callout: UIView {
    private let titleLabel = UILabel(frame: .zero)
    let subtitleLabel = UILabel(frame: .zero)
    let subtitleLabel2 = UILabel(frame: .zero)
    private let imageView = UIImageView(frame: .zero)
    private let annotation: Annotation
    let descripcion = UILabel(frame: .zero)
    
    
    
    
    init(annotation: Annotation) {
        self.annotation = annotation
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        setupTitle()
        setupSubtitle()
        setupSubtitle2()
        setupDescription()
        setupImageView()
    }
    
    private func setupTitle() {
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.text = annotation.name
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }
    
    private func setupSubtitle() {
        subtitleLabel.font = UIFont.systemFont(ofSize: 14)
        subtitleLabel.textColor = .systemBlue
        subtitleLabel.text = "Ver Descripción"
        subtitleLabel.isUserInteractionEnabled = true
        subtitleLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showDetails)))
        
        addSubview(subtitleLabel)
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8).isActive = true
        subtitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        subtitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        subtitleLabel.alpha = 1
    }
    private func setupSubtitle2() {
        subtitleLabel2.font = UIFont.systemFont(ofSize: 14)
        subtitleLabel2.textColor = .systemBlue
        subtitleLabel2.text = "Ver Imagen"
        subtitleLabel2.isUserInteractionEnabled = true
        subtitleLabel2.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showImage)))
        
        addSubview(subtitleLabel2)
        subtitleLabel2.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel2.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8).isActive = true
        subtitleLabel2.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        subtitleLabel2.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        subtitleLabel2.alpha = 0
    }
    
    private func setupDescription() {
        descripcion.text = annotation.heroeDescription
        descripcion.textColor = .gray
        descripcion.numberOfLines = 0
        descripcion.font = UIFont.boldSystemFont(ofSize: 12)
        addSubview(descripcion)
        descripcion.translatesAutoresizingMaskIntoConstraints = false
        descripcion.alpha = 0
        descripcion.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 8).isActive = true
        descripcion.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        descripcion.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
    }
    
    @objc func showDetails(){
        imageView.alpha = 0
        subtitleLabel2.alpha = 1
        subtitleLabel.alpha = 0
        descripcion.alpha = 1
        
        
    }
    @objc func showImage(){
        imageView.alpha = 1
        subtitleLabel2.alpha = 0
        subtitleLabel.alpha = 1
        descripcion.alpha = 0
        
    }
    
    private func setupImageView() {
        imageView.kf.setImage(with: URL(string: annotation.photo!))
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 8).isActive = true
        imageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 280).isActive = true
        imageView.alpha = 1
    }
}
