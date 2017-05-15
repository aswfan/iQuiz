import UIKit

class TableViewController: UITableViewController {
    
    let _url = "https://tednewardsandbox.site44.com/questions.json"
    
    func handleRefresh(_ refreshControl: UIRefreshControl) {
        // Do some reloading of data and update the table view's data source
        // Fetch more objects from a web service, for example...
        
        // Simply adding an object to the data source for this example
        self.popoverHandler(url: url)
        refreshControl.endRefreshing()
    }
    
    // MARK: Delegate
    //
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.setSelected(false, animated: true)
        self.switchView(title: titles?[indexPath.row])
    }
    
    
    func switchView(title: String?) {
        if title == _url {
            print("Something went wrong!")
            return
        }
        let identifier = "question"
        let vc = ConfigViewControlloer(identifier: identifier) as! QuestionViewController
        
        vc.questions = self.questions[title!]
        vc.answers = self.answers[title!]
        vc.supercontroller = self
        vc.TITLE = title!
        
        self.present(vc, animated: true, completion: nil)
    }
    
    func ConfigViewControlloer(identifier: String) -> UIViewController {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        return sb.instantiateViewController(withIdentifier: identifier)
    }
    
    @IBAction func SettingBtnPressDown(_ sender: UIBarButtonItem) {
        let identifier = "popover"
        
        let vc = ConfigViewControlloer(identifier: identifier) as! PopoverViewController
        
        vc.supercontroller = self
        
        vc.modalPresentationStyle = .popover
        
        self.addChildViewController(vc)
        vc.view.frame = self.view.frame
        self.view.addSubview(vc.view)
        vc.view.didMoveToSuperview()
        
    }
    
    @IBAction func getScores(_ sender: Any) {
        let identifier = "scorepopover"
        
        let vc = ConfigViewControlloer(identifier: identifier) as! ScorePopoverViewController
        
        var text = "no score!"
        if self.score.count > 0 {
            text = self.score.description.replacingOccurrences(of: "[", with: "")
                .description.replacingOccurrences(of: "]", with: "")
                .replacingOccurrences(of: "\"", with: "")
        }
        vc.text = text
        vc.count = score.count
        
        vc.modalPresentationStyle = .popover
        
        self.addChildViewController(vc)
        vc.view.frame = self.view.frame
        self.view.addSubview(vc.view)
        vc.view.didMoveToSuperview()

    }
    
    var url = ""
    func popoverHandler(url: String?) {
        ConnectToServer(urlString: url)
    }
    
    let security = "https://"
    let insecurity = "http://"
    
    func ConnectToServer(urlString: String?) {
        var url = urlString
        if url == nil {
            print("Invalid URL!")
            url = self._url
        }
        if url?.range(of: security) == nil  {
            if let range = url?.range(of: insecurity)  {
                url?.removeSubrange(range)
            }
            url = security + url!
        }
        DispatchQueue.global(qos: .userInitiated).async {
            self.fetchDataFromServer(url!)
        }
    }
    
    func validateUrl (urlString: String) -> Bool {
        return UIApplication.shared.canOpenURL(URL(string: urlString)!)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        ConnectToServer(urlString: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        UserDefaults.standard.set(self.questions, forKey: "questions")
        UserDefaults.standard.set(self.answers, forKey: "answers")
        UserDefaults.standard.set(titles, forKey: "titles")
        UserDefaults.standard.set(dess, forKey: "dess")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.tableView.tableFooterView = UIView()
        
        self.refreshControl?.addTarget(self, action: #selector(ViewController.handleRefresh(_:)), for: UIControlEvents.valueChanged)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    var titles: [String]? = []
    var imgs: [String: UIImage]? = nil
    var dess: [String]? = []
    
    var questions = [String: [[[String]]]]()
    var answers = [String: [Int]]()
    var score = [String: String]()
    
    // MARK: Data Source
    //
    @available(iOS 2.0, *)
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles!.count
    }
    
    @available(iOS 2.0, *)
    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        let cellIdentifier = "myTableCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? myTableViewCell ?? myTableViewCell(style: .subtitle, reuseIdentifier: cellIdentifier)
        let title = (titles?[row])!
        cell.title?.text = title
        var icon = #imageLiteral(resourceName: "0 Percents Filled")
        
        if score.index(forKey: title) != nil {
            switch Double(score[title]!)! {
            case 0...0.124:
                icon = #imageLiteral(resourceName: "0 Percents Filled")
            case 0.125...0.374:
                icon = #imageLiteral(resourceName: "25 Percents Filled")
            case 0.375...0.624:
                icon = #imageLiteral(resourceName: "50 Percents Filled")
            case 0.625...0.874:
                icon = #imageLiteral(resourceName: "75 Percents Filled")
            default:
                icon = #imageLiteral(resourceName: "100 Percents Filled")
            }
        }
        cell.img?.image = icon
        cell.des?.text = dess?[row]
        return cell
    }
    
    // MARK: fetch data from server
    func fetchDataFromServer(_ serverURL: String) {
        let url = URL(string: serverURL)
        URLSession.shared.dataTask(with:url!) { (data, response, error) in
            if error != nil {
                if let questions = UserDefaults.standard.value(forKey: "question") as? [String: [[[String]]]] {
                    DispatchQueue.main.async {
                        self.questions = questions
                    }
                }
                if let answers = UserDefaults.standard.value(forKey: "answers") as? [String: [Int]] {
                    DispatchQueue.main.async {
                        self.answers = answers
                    }
                }
                if let titles = UserDefaults.standard.value(forKey: "titles") as? [String] {
                    DispatchQueue.main.async {
                        self.titles = titles
                    }
                }
                if let dess = UserDefaults.standard.value(forKey: "dess") as? [String] {
                    DispatchQueue.main.async {
                        self.dess = dess
                    }
                }
                print("No Internet Connection!")
            } else {
                DispatchQueue.main.async(execute: {
                    self.titles?.removeAll()
                    self.dess?.removeAll()
                })
                do {
                    let json = try JSONSerialization.jsonObject(with: data!) as? [[String: Any]]
                    for dict in json! {
                        let title = dict["title"] as! String
                        DispatchQueue.main.async {
                            self.titles?.append(title)
                            self.dess?.append(dict["desc"] as! String)
                            self.questions[title] = [[[String]]]()
                            self.answers[title] = [Int]()
                        }
                        
                        if let ques = dict["questions"] as? [[String: Any]] {
                            for item in ques {
                                var strs = [[String]]()
                                var str = [String]()
                                if let text = item["text"] as? String {
                                    str.append(text)
                                    strs.append(str)
                                }
                                if let ans = item["answer"] as? String {
                                    DispatchQueue.main.async(execute: {
                                        self.answers[title]?.append(Int(ans)!)
                                    })
                                }
                                if let anss = item["answers"] as? [String] {
                                    strs.append(anss)
                                }
                                DispatchQueue.main.async(execute: {
                                    self.questions[title]?.append(strs)
                                })
                            }
                            
                        }
                        
                    }
                } catch let error as NSError {
                    print(error)
                }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
            
            }.resume()
        
    }
    
}
