//
//  ViewController.swift
//  QiitaAPI
//
//  Created by Haruko Okada on 2/15/21.
//

import UIKit
import SafariServices

protocol  controllerInput {
    var numberOfItems: Int{get}
    func fetchApi()
    func item(forRow row: Int) -> Qiita?
    func loadSelectedQiita(at indexPath: IndexPath)
}

protocol controllerOutput {
    func reloadData()
}

class ViewController: UIViewController {
    
    private(set) lazy var apiModel = ApiModel()
    private var qiitaArray:[Qiita] = []
    
    private(set) lazy var myView: QiitaTable = QiitaTable()

    override func viewDidLoad() {
        navigationItem.title = "Qiita一覧"

        print("viewDidLoad")
    }
   
    override func loadView() {
       fetchApi()
        view = myView
        print("loadView")

    }
    
    var numberOfItems: Int {
        return qiitaArray.count
    }
    
    func item(forRow row: Int) -> Qiita? {
        guard row < qiitaArray.count else {
            return nil
        }
        return qiitaArray[row]
    }
    
    
    func fetchApi() {
        apiModel.getQiitaApi { (qiitaArticle) in
            self.qiitaArray = qiitaArticle
            DispatchQueue.main.async {
                self.myView.tableView.reloadData()
            }
        }
        
        print(qiitaArray)
        print(qiitaArray.count)
        print("i ran")
    }

    func loadSelectedQiita(at indexPath: IndexPath) {
        let url = URL(string: qiitaArray[indexPath.row].url)
        if let url = url{
            let vc = SFSafariViewController(url: url)
            present(vc, animated: true, completion: nil)
        }
    }


}



