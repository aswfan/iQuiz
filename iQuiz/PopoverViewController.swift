//
//  PopoverViewController.swift
//  iQuiz
//
//  Created by iGuest on 5/13/17.
//  Copyright © 2017 yyfan. All rights reserved.
//

import UIKit

class PopoverViewController: UIViewController {
    
    var supercontroller: TableViewController? = nil

    @IBOutlet weak var URLField: UITextField!
    
    @IBAction func CheckBtnOnClick(_ sender: UIButton) {
        if let url = URLField.text {
            supercontroller?.url = url
            supercontroller?.popoverHandler(url: url)
        }
        self.view.removeFromSuperview()
    }
    
    @IBAction func CancelBtnOnClick(_ sender: UIButton) {
        self.view.removeFromSuperview()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
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
