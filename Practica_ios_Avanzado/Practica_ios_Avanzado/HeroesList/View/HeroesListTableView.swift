//
//  HeroesListTableView.swift
//  Practica_ios_Avanzado
//
//  Created by Enrique Poyato Ortiz on 14/2/23.
//

import Foundation
import UIKit

class HeroesListTableView: UIView {
    
    
    let circuloCarga: UIActivityIndicatorView =  {
        let activityIndicatorView = UIActivityIndicatorView(style: .large)
        activityIndicatorView.color = .orange
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        
        return activityIndicatorView
    }()
    
    
    let logout: UIImageView = {
        
        let image = UIImageView(image: UIImage(named: "close"))
        image.isUserInteractionEnabled = true
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
    }()
    
    let deleteCoreDataButtom: UIButton = {
        
        let button = UIButton(type: .close)
        button.setTitle("CoreData", for: .normal)
        button.backgroundColor = UIColor.blue
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
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
    
    let searchBar: UISearchBar = {
        let search = UISearchBar()
        search.searchBarStyle = .minimal
        
        search.translatesAutoresizingMaskIntoConstraints = false
        return search
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
        addSubview(deleteCoreDataButtom)
        addSubview(logout)
        addSubview(headerLabel)
        addSubview(searchBar)
        addSubview(tableView)
        addSubview(circuloCarga)
        
        NSLayoutConstraint.activate([
            
            deleteCoreDataButtom.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 5),
            deleteCoreDataButtom.trailingAnchor.constraint(equalTo: logout.leadingAnchor, constant: -200),
            deleteCoreDataButtom.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            deleteCoreDataButtom.heightAnchor.constraint(equalToConstant: 30),
            deleteCoreDataButtom.widthAnchor.constraint(equalToConstant: 60),
            
            logout.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            logout.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            logout.heightAnchor.constraint(equalToConstant: 40),
            logout.widthAnchor.constraint(equalToConstant: 40),
            
            headerLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            headerLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            headerLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            headerLabel.heightAnchor.constraint(equalToConstant: 40),
            
            searchBar.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 20),
            searchBar.leadingAnchor.constraint(equalTo: leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: trailingAnchor),
            searchBar.bottomAnchor.constraint(equalTo: tableView.topAnchor),
            
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            circuloCarga.centerXAnchor.constraint(equalTo: centerXAnchor),
            circuloCarga.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    func getLougoutButton() -> UIImageView {
        
        return logout
    }
}


