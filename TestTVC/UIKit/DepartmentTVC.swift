//
//  DepartmentTVC.swift
//  TestUIKitTVC
//
//  Created by Felix Marianayagam on 2/29/20.
//  Copyright © 2020 SubhaFelix. All rights reserved.
//

import UIKit
import CoreData

class DepartmentTVCell: UITableViewCell {
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var label: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

class DepartmentTVC: UITableViewController, DataAccess {
    
    var departmentsFRC: NSFetchedResultsController<Department>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        departmentsFRC = self.getDepartmentsFRC(viewContext: context, deleteCache: true)
        if self.departmentsFRC?.sections?.first?.numberOfObjects == 0 {
            self.addSampleDepartments(viewContext: context)
            departmentsFRC = self.getDepartmentsFRC(viewContext: context, deleteCache: true)
        }
    }

    func registerCell() {
        self.tableView.register(DepartmentTVCell.self, forCellReuseIdentifier: "Cell")
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return departmentsFRC?.sections?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return departmentsFRC?.sections?[section].numberOfObjects ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! DepartmentTVCell
        // Error: The label & cell are nil at runtime
        cell.label.text = departmentsFRC?.object(at: indexPath).name
        cell.view.backgroundColor = .random()
        // Issue: Only the below code works
        cell.textLabel?.text = departmentsFRC?.object(at: indexPath).name
        return cell
    }
}

extension UIColor {
    static func random() -> UIColor {
        return UIColor(red:   .random(in: 0...1),
                       green: .random(in: 0...1),
                       blue:  .random(in: 0...1),
                       alpha: .random(in: 0...1))
    }
}
