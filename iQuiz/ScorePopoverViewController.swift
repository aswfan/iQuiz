//
//  ScorePopoverViewController.swift
//  iQuiz
//
//  Created by iGuest on 5/15/17.
//  Copyright © 2017 yyfan. All rights reserved.
//

import UIKit

class ScorePopoverViewController: UIViewController {

    var text = ""
    var count = 0
    
    @IBOutlet weak var scorelabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if count > 1 {
            scorelabel.numberOfLines = count
            
        }
        scorelabel.text = text
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        
    }

    @IBAction func DoneBtnOnclick(_ sender: UIButton) {
        self.view.removeFromSuperview()
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
