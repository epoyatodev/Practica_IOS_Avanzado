//
//  HeroesListTableViewController.swift
//  Practica_ios_Avanzado
//
//  Created by Enrique Poyato Ortiz on 14/2/23.
//

import UIKit

class HeroesListTableViewController: UIViewController {
    
    var mainView:  HeroesListTableView { self.view as! HeroesListTableView }
    var heroesListCoreDataFiltered: [Hero] = []
    var heroesList: [HeroModel] = []
    
    private var tableViewDataSource: HeroesListTableViewDataSource?
    private var tableVideDelegate: HeroesListTableViewDelegate?
    
    private var heroeListViewModel = HeroesListViewModel()
    private var heroesMapViewModel = HeroesMapViewModel()
    private var loginViewModel = LoginViewModel()
    
    private var loginViewController: LoginViewController?
    
    
    override func loadView() {
        view = HeroesListTableView()

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gestureTap = UITapGestureRecognizer(target: self, action: #selector(logout(_:)))
        mainView.logout.addGestureRecognizer(gestureTap)
        
        mainView.deleteCoreDataButtom.addTarget(self, action: #selector(deleteCoreData), for: .touchUpInside)
        
        
        
        setTableElements()
        setDidTapOnCell()
        addNotification()
        // Check if user is logged in
        if readDataKeychain(getEmail()) == "" {
            
            presentLoginViewController()
            return
        }
        
        getFullHeroeApiClient()

        
    }
    
    
    // MARK: Actions
    
    func presentLoginViewController() {
        // Creo el login view controller
        loginViewController = LoginViewController()
        
        // show the login view controller
        if let loginViewController { // swift 5.7
            loginViewController.modalPresentationStyle = .fullScreen
            self.navigationController?.present(loginViewController, animated: true)
        }
    }
    
    
    
    func addNotification() {
        // Comienzo a "escuchar" la notificación que me interesa
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(loginResult(_:)),
                                               name: NSNotification.Name("notification.login.result"),
                                               object: nil)
    }
    
    func removeNotification() {
        NotificationCenter.default.removeObserver(self,
                                                  name: NSNotification.Name("notification.login.result"),
                                                  object: nil)
    }
    
    
    
    private func getFullHeroeApiClient() {
        if getHeroesCoreData().isEmpty {
            mainView.circuloCarga.startAnimating()

            print("Heroes ApiClient")
            let moveToMain = { (heroes: [HeroModel]) -> Void in
                heroes.forEach { saveHeroeCoreData($0.id, $0.photo, $0.name, $0.description, String($0.longitud!), String($0.latitud!)) } // Guardo en coreData el Heroe + Localizaciones
                self.heroesListCoreDataFiltered = getHeroesCoreData()

                self.tableViewDataSource?.set(heroes: getHeroesCoreData())

                
                self.mainView.circuloCarga.stopAnimating()
            }
            
            let updateFullItems = { (heroes: [HeroModel]) -> Void in
                
                let group = DispatchGroup()
                
                for hero in heroes {
                    group.enter()
                    
                    self.heroesMapViewModel.updateUI = { [weak self] heroe,  heroLocations in
                        var fullHero = heroe
                        if let firstLocation = heroLocations.first {
                            fullHero.latitud = Double(firstLocation.latitud)
                            fullHero.longitud = Double(firstLocation.longitud)
                        } else {
                            fullHero.latitud = 0.0
                            fullHero.longitud = 0.0
                        }
                        self?.heroesList.append(fullHero)
                        group.leave()
                    }
                    self.heroesMapViewModel.getData(hero)
                }
                
                group.notify(queue: .main) {

                    moveToMain(self.heroesList)
                    
                }
            }
            
            
            self.heroeListViewModel.updateUI = { heroes in

                updateFullItems(heroes)
            }
            self.heroeListViewModel.getData()
        }else{
            print("HeroesCoreData")
            tableViewDataSource?.set(heroes: getHeroesCoreData())

            //tableViewDataSource?.set(heroes: heroesListCoreDataFiltered)

        }
        
    }
    
    
    
    
    //MARK: Table
    
    func setTableElements(){
        tableVideDelegate = HeroesListTableViewDelegate()
        tableViewDataSource = HeroesListTableViewDataSource(tableView: mainView.tableView)
        mainView.searchBar.delegate = self
        mainView.tableView.dataSource = tableViewDataSource
        mainView.tableView.delegate = tableVideDelegate
    }
    
    private func setDidTapOnCell() {
                tableVideDelegate?.didTapOnCell = { [weak self] index in
                    guard let datasource = self?.tableViewDataSource else { return }
        
                    let heroModel = datasource.heroes[index]
        
                    let heroDetailViewController = HeroDetailViewController(heroModel: heroModel)
        
                    // Presentamos el nuevo view controller
                    self?.present(heroDetailViewController, animated: true)
                }
    }
    
    
    // MARK: Objc Func
    
    @objc
    func logout(_ gestureTap: UITapGestureRecognizer) {
        deleteTokenKeychain(getEmail())
        presentLoginViewController()
        
        
    }
    
    @objc
    func deleteCoreData(){
        deleteHeroesCoreData()
        self.mainView.tableView.reloadData()
    }
    
    @objc
    func loginResult(_ notification: Notification) {
        let result = notification.userInfo?["miData"] as? [String: Any]
        
        if let result {
            debugPrint("Notification result -> \(result)")
            
            if let token = result["token"] as? String, !token.isEmpty {
                // oculto el formulario de login
                DispatchQueue.main.async {
                    self.loginViewController?.dismiss(animated: true)
                    self.getFullHeroeApiClient()
                }
            }
        }
    }
    
    
}

// MARK: - Extension

extension HeroesListTableViewController: UISearchBarDelegate{
    // Identificar cuando el usuario comienza a escribir
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        heroesListCoreDataFiltered = []
        
        if searchText == "" {
            heroesListCoreDataFiltered = getHeroesCoreData()
        }else{
            for heroe in getHeroesCoreData(){
                if heroe.name.lowercased().contains(searchText.lowercased()){
                    heroesListCoreDataFiltered.append(heroe)
                }
            }
        }
        // Cada vez que cambio el texto se va actualizando la tabla
        DispatchQueue.main.async {
            self.tableViewDataSource?.set(heroes: self.heroesListCoreDataFiltered)

        }
    }
}


