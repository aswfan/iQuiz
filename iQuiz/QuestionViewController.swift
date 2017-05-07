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
    
    var totalScore = 0
    var score = 0
    
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
    
    @IBAction func SwipeGesture(_ sender: Any) {
        
    }
    
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
            let ip = IndexPath.init(row: num!, section: 1)
            
            if oldip != nil && oldip?.row == num {
                score += 1
            }
            
            if oldip != nil && oldip?.row != num {
                tv.cellForRow(at: oldip!)?.contentView.superview?.backgroundColor = UIColor.red
                
            }
            tv.cellForRow(at: ip)?.contentView.superview?.backgroundColor = UIColor.green

        }
        else {
            sender.title = SUBMIT
            
            Num += 1
            if Num == answers?.count {
                toReport()
            }
            else {
                tv.reloadData()
                let num = answers?[Num]
                let ip = IndexPath.init(row: num!, section: 1)
                if oldip != nil {
                    if let cell = tv.cellForRow(at: oldip!) {
                        cell.contentView.superview?.backgroundColor = UIColor.clear
                        cell.accessoryType = .none
                    }
                }
                tv.cellForRow(at: ip)?.contentView.superview?.backgroundColor = UIColor.clear
                
                oldip = nil
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
        vc.report.text = "Your Grade: \(score) of \(totalScore) correct!"
        vc.didMove(toParentViewController: self)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        totalScore = (questions?.count)!
        
        tv.delegate = self
        tv.dataSource = self
        
        self.tv.tableFooterView = UIView()
        
        let swipeleft = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture(gesture:)))
        swipeleft.direction = .left
        let swiperight = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture(gesture:)))
        swiperight.direction = .right
        
        self.tv.addGestureRecognizer(swipeleft)
        self.tv.addGestureRecognizer(swiperight)
        
    }
    
    func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            if swipeGesture.direction == .right {
                quitBtnClick(UIBarButtonItem())
            }
            else {
                nextBtnClick(UIBarButtonItem())
            }
        }
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
