//
//  QuizTableView.swift
//  iQuiz
//
//  Created by iGuest on 4/28/17.
//  Copyright © 2017 yyfan. All rights reserved.
//

import UIKit

class QuizTableView: UITableView, UITableViewDataSource {
    
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
        let cellIdentifier = "QuizTableCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? QuizTableViewCell ?? QuizTableViewCell(style: .subtitle, reuseIdentifier: cellIdentifier)
        cell.title?.text = titles?[row]
        cell.img?.image = imgs?[row]
        cell.des?.text = dess?[row]
        return cell
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.dataSource = self
    }
    
    
    
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
