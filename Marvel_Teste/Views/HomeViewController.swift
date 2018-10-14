//
//  ViewController.swift
//  Marvel_Teste
//
//  Created by Rafael Gabriel on 13/10/2018.
//  Copyright © 2018 Rafael Gabriel. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import EasyPeasy

class HomeViewController: UIViewController {
    
    @IBOutlet weak var tableView:UITableView!
    private var buzy = UIActivityIndicatorView()
    
    private let cellKey = "cellKeyCharacter"
    private let detailSegue = "detailSague"
    
    private let modelView = HomeViewModel()
    private let disposeBag = DisposeBag()
    
    private var maxItems = -1
    private var isLoad = false
    private var characterSelected:Character?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.register(UINib(nibName: "CharacterTableViewCell", bundle: nil), forCellReuseIdentifier: cellKey)
        buzySetup()
        
        bind()
        loadData()
    }
    
    func alertMessage(title:String, message:String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
    func buzySetup() -> () {
        self.view.addSubview(buzy)
        buzy.easy.layout([
            Bottom(0),
            Left(0),
            Right(0),
            Height(40)
        ])
        buzy.color = UIColor.black
        buzy.hidesWhenStopped = true
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 40, right: 0)
    }
    
    //MARK: - Data
    
    func loadData() {
        if (isLoad) { return }
        isLoad = true
        buzy.startAnimating()
        let offset = modelView.characters.value.count
        
        MarvelService.shared.sendRequestCharacters(offset) { [weak self](marvelResult) in
            self?.isLoad = false
            DispatchQueue.main.async {
                self?.buzy.stopAnimating()
            }
            guard let marvelResult = marvelResult else { return }
            if (marvelResult.code != 200) { return }
            if (self == nil) { return }
            self?.modelView.characters.accept(self!.modelView.characters.value + marvelResult.data.results)
            self?.maxItems = marvelResult.data.limit
        }
    }

    //MARK: - RX
    
    func bind() {
        modelView.characters.bind(to: tableView.rx.items(cellIdentifier: cellKey,
                                                   cellType: CharacterTableViewCell.self))
        { [weak self] row, character, cell in
            cell.character = character
            if (self == nil) { return }
            if (row == self!.modelView.characters.value.count - 1) {
                self?.loadData()
            }
        }.disposed(by: self.disposeBag)
        
        Observable.zip(tableView.rx.itemSelected, tableView.rx.modelSelected(Character.self))
            .bind { [weak self] (indexpath, character) in
                print("\(character.name)")
                self?.characterSelected = character
                self?.performSegue(withIdentifier: self!.detailSegue, sender: nil)
        }.disposed(by: disposeBag)
    }
    
    //MARK: - Transactions
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == detailSegue) {
            let vc = segue.destination as! DetailViewController
            vc.character = self.characterSelected
        }
    }

}

