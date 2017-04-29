//
//  QuestionViewController.swift
//  iQuiz
//
//  Created by iGuest on 4/29/17.
//  Copyright © 2017 yyfan. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {

    @IBAction func quitBtnClick(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func nextBtnClick(_ sender: UIBarButtonItem) {

        
        toReport()
        
        
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
