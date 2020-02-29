//
//  ContentView.swift
//  TestTVC
//
//  Created by Felix Marianayagam on 2/29/20.
//  Copyright © 2020 SubhaFelix. All rights reserved.
//

import SwiftUI
import CoreData

struct ContentView: View, DataAccess {
    var body: some View {
        DepartmentTVCRepresentable()
    }
}

struct DepartmentTVCRepresentable: UIViewControllerRepresentable {
    typealias UIViewControllerType = DepartmentTVC
    @Environment(\.managedObjectContext) var viewContext

    func makeUIViewController(context: UIViewControllerRepresentableContext<DepartmentTVCRepresentable>) -> DepartmentTVC {
        let departmentTVC = DepartmentTVC()
        // Must register cell when using in SwiftUI, even though the prototype cell is created via storyboard.
        departmentTVC.registerCell()
        return departmentTVC
    }
    
    func updateUIViewController(_ uiViewController: DepartmentTVC, context: UIViewControllerRepresentableContext<DepartmentTVCRepresentable>) {
    }
}
