//
//  QuestionViewController.swift
//  iQuiz
//
//  Created by iGuest on 4/29/17.
//  Copyright © 2017 yyfan. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let SUBMIT = "Submit"
    let NEXT = "Next"
    
    @IBOutlet weak var tv: UITableView!
    
    var Num = 0
    var questions: [[[String]]]? =
        [
            [
                ["What is fire?"],
                ["One of the four classical elements",
                 "A magical reaction given to us by God",
                 "A band that hasn't yet been discovered",
                 "Fire! Fire! Fire! heh-heh"]
            ]
        ]
    var answers: [Int]? = [1]
    
    // data source
    @available(iOS 2.0, *)
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questions![Num][section].count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Question"
        }
        else {
            return "Options"
        }
    }
    
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = indexPath.section
        let row = indexPath.row
        let cellIdentifier = "cell"
        let cell = tv.dequeueReusableCell(withIdentifier: cellIdentifier) ?? UITableViewCell(style: .subtitle, reuseIdentifier: cellIdentifier)
        
        cell.textLabel?.text = questions?[Num][section][row]
        if section == 0 {
            cell.isUserInteractionEnabled = false
        }
        return cell
    }

    // Delegate
    
    var oldip: IndexPath? = nil
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if oldip != nil {
            tableView.cellForRow(at: oldip!)?.accessoryType = UITableViewCellAccessoryType.none
        }
        let cell = tableView.cellForRow(at: indexPath)
        cell?.setSelected(false, animated: true)
        cell?.accessoryType = UITableViewCellAccessoryType.checkmark
        
        oldip = indexPath
    }

    

    @IBAction func quitBtnClick(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func nextBtnClick(_ sender: UIBarButtonItem) {
        if sender.title == SUBMIT {
            sender.title = NEXT
            
            let num = answers?[Num]
            if oldip?.row != num {
                tv.cellForRow(at: oldip!)?.contentView.superview?.backgroundColor = UIColor.red
                
            }
            let ip = IndexPath.init(row: num!, section: 1)
            tv.cellForRow(at: ip)?.contentView.superview?.backgroundColor = UIColor.green
            
            

        }
        else {
            sender.title = SUBMIT
            
            Num += 1
            if Num == answers?.count {
                toReport()
            }
        }
        
    }
    
    private func toReport() {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc: ReportViewController = sb.instantiateViewController(withIdentifier: "report") as! ReportViewController
        
        // add properties if needed
        
        
        
        for view in self.view.subviews {
            view.removeFromSuperview()
        }
        
        self.addChildViewController(vc)
        self.view.insertSubview(vc.view, at: 0)
        vc.didMove(toParentViewController: self)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tv.delegate = self
        tv.dataSource = self
        
        self.tv.tableFooterView = UIView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
