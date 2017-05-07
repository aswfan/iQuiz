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
        self.questions.removeAll()
        self.answers.removeAll()
        DispatchQueue.global(qos: .userInitiated).async {
            self.fetchDataFromServer("https://tednewardsandbox.site44.com/questions.json", with: (self.titles?[indexPath.row])! )
//            DispatchQueue.main.async {
//                self.switchView()
//            }
        }
        
    }
    
    func switchView() {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc: QuestionViewController = (sb.instantiateViewController(withIdentifier: "question") as? QuestionViewController)!
        
        vc.questions = self.questions
        vc.answers = self.answers
        
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
    
    var questions = [[[String]]]()
    var answers = [Int]()
    
    
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
    func fetchDataFromServer(_ serverURL: String, with: String) {
        let url = URL(string: serverURL)
        URLSession.shared.dataTask(with:url!) { (data, response, error) in
            if error != nil {
                print(error!)
            } else {
                do {
                    let json = try JSONSerialization.jsonObject(with: data!) as? [[String: Any]]
                    for dict in json! {
                        if let title = dict["title"] as? String {
                            if title.range(of: with) == nil {
                                continue
                            }
                            if let ques = dict["questions"] as? [[String: Any]] {
                                for item in ques {
                                    var strs = [[String]]()
                                    var str = [String]()
                                    if let text = item["text"] as? String {
                                        str.append(text)
                                    }
                                    if str.count != 0 {
                                        strs.append(str)
                                    }
                                    else {
                                        strs.append([" "])
                                    }
                                    if let ans = item["answer"] as? String {
                                        DispatchQueue.main.async(execute: {
                                            self.answers.append(Int(ans)!)
                                        })
                                    }
                                    if let anss = item["answers"] as? [String] {
                                        strs.append(anss)
                                    }
                                    DispatchQueue.main.async(execute: {
                                        self.questions.append(strs)
                                    })
                                }
                                
                            }
                        }
                        
                    }
                } catch let error as NSError {
                    print(error)
                }
                DispatchQueue.main.async(execute: {
                    self.switchView()
                })
            }
            
            }.resume()
        
    }

}


