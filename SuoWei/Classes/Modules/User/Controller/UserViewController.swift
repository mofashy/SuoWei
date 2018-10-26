//
//  UserViewController.swift
//  SuoWei
//
//  Created by 沈永聪 on 2018/9/21.
//  Copyright © 2018年 沈永聪. All rights reserved.
//

import UIKit

class UserViewController: BaseViewController {
    
    //MARK:- Members
    fileprivate let cell_reuseIdentifier = "UserCell"
    
    var tableView: UITableView!
    var headerView: UserHeaderView!
    var titles: [TitleViewModel]?
    var user: UserViewModel!

    //MARK:- Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        debugData()
    }
    
    override func loadView() {
        super.loadView()
        
        let width = suowei_screen_width * 0.8
        tableView = UITableView()
        tableView.frame = CGRect(x: -width, y: 0, width: width, height: suowei_screen_height)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 55
        tableView.separatorStyle = .none
        view = tableView
        
        tableView.register(UserCell.self, forCellReuseIdentifier: cell_reuseIdentifier)
        
        headerView = UserHeaderView(frame: CGRect(x: 0, y: 0, width: suowei_screen_width, height: 120))
        tableView.tableHeaderView = headerView
    }
    
    //MARK:- Debug
    func debugData() {
        DispatchQueue.global(qos: .background).async {
            var path = Bundle.main.path(forResource: "user", ofType: "json")!
            var data = try! Data(contentsOf: URL.init(fileURLWithPath: path))
            if let user = try? JSONDecoder().decode(UserModel.self, from: data) {
                self.user = UserViewModel.init(with: user)
            }
            
            path = Bundle.main.path(forResource: "titles", ofType: "json")!
            data = try! Data(contentsOf: URL.init(fileURLWithPath: path))
            if let titles = try? JSONDecoder().decode([TitleModel].self, from: data) {
                self.titles = titles.map{ TitleViewModel.init(with: $0) }
            }
            
            DispatchQueue.main.async {
                self.headerView.configure(with: self.user)
                self.tableView.reloadData()
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


//MARK:- UITableViewDataSource
extension UserViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cell_reuseIdentifier) as! UserCell
        cell.configure(with: titles?[indexPath.row])
        
        return cell
    }
}


//MARK:- UITableViewDelegate
extension UserViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        slidesVC?.toggleMenu()
    }
}
