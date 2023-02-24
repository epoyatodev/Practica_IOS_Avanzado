//
//  HeroesListTableView.swift
//  Practica_ios_Avanzado
//
//  Created by Enrique Poyato Ortiz on 14/2/23.
//

import Foundation
import UIKit

class HeroesListTableView: UIView {
    
    let logout: UIImageView = {
       
        let image = UIImageView(image: UIImage(named: "close"))
        image.isUserInteractionEnabled = true
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
    }()
    
    
    
    let headerLabel: UILabel = {
       let label = UILabel()
        label.text = "Heroes"
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let tableView: UITableView = {
       let table = UITableView()
        //Registrar la celda
        table.register(HeroeListViewCell.self, forCellReuseIdentifier: "HeroeListViewCell")
        table.translatesAutoresizingMaskIntoConstraints = false
        
        return table
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        // Views
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupViews() {
        backgroundColor = .white
        addSubview(logout)

        addSubview(headerLabel)
        addSubview(tableView)
        
        
        NSLayoutConstraint.activate([
            logout.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            logout.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            logout.heightAnchor.constraint(equalToConstant: 40),
            logout.widthAnchor.constraint(equalToConstant: 40),
            
            headerLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            headerLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            headerLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            headerLabel.heightAnchor.constraint(equalToConstant: 40),
            
            
            
            tableView.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    func getLougoutButton() -> UIImageView {
        
        return logout
    }
}


