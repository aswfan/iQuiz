//
//  ViewController.swift
//  iQuiz
//
//  Created by iGuest on 4/28/17.
//  Copyright © 2017 yyfan. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate {

    @IBOutlet weak var quizTable: QuizTableView!
    
    // Delegate
    //
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
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
        
        quizTable.delegate = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

