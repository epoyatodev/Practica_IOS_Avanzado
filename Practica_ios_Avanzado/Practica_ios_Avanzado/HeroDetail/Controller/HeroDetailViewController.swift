//
//  HeroDetailViewController.swift
//  Practica_ios_Avanzado
//
//  Created by Enrique Poyato Ortiz on 14/2/23.
//
import Foundation
import UIKit

class HeroDetailViewController: UIViewController {
    var mainView: HeroDetailView {self.view as! HeroDetailView}
    
    private var heroModel: Hero?
    
    private var heroeDetailViewModel: HeroDetailViewModel?
    private var loginViewModel = LoginViewModel()

    init(heroModel: Hero) {
        super.init(nibName: nil, bundle: nil)
        self.heroModel = heroModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = HeroDetailView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let heroModel = self.heroModel else { return }
        
        self.getHeroDetails(heroDetailModel: heroModel)
    }
    
    func getHeroDetails(heroDetailModel: Hero) {
        DispatchQueue.main.async {
            self.mainView.configure(heroDetailModel)
        }
    }
}
