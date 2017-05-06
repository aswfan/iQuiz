//
//  ViewController.swift
//  iQuiz
//
//  Created by iGuest on 4/28/17.
//  Copyright © 2017 yyfan. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var quizTable: UITableView!
    
    // Delegate
    //
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.setSelected(false, animated: true)
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc: UIViewController = sb.instantiateViewController(withIdentifier: "question")
        
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func SettingBtnPressDown(_ sender: Any) {
        let alert = UIAlertController(title: "", message: "Settings go here", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        quizTable.dataSource = self
        quizTable.delegate = self
        
        quizTable.tableFooterView = UIView()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    var titles: [String]? = ["Mathematics", "Marvel Super Heroes", "Science"]
    var imgs: [UIImage]? = [#imageLiteral(resourceName: "Math"), #imageLiteral(resourceName: "Marvel"), #imageLiteral(resourceName: "Science")]
    var dess: [String]? = ["I love Math", "Batman is super cool", "Science makes world better"]
    
    
    // Data Source
    //
    @available(iOS 2.0, *)
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles!.count
    }
    
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        let cellIdentifier = "myTableCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? myTableViewCell ?? myTableViewCell(style: .subtitle, reuseIdentifier: cellIdentifier)
        cell.title?.text = titles?[row]
        cell.img?.image = imgs?[row]
        cell.des?.text = dess?[row]
        return cell
    }

    // fetch data from server
    func fetchDataFromServer(_ serverURL: String) {
        let url = URL(string: serverURL)
    }

}


