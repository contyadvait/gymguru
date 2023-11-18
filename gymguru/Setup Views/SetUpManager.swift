//
//  SetUpManager.swift
//  gymguru
//
//  Created by Milind Contractor on 17/11/23.
//

import SwiftUI

struct SetUpManager: View {
    @Binding var name: String
    @State var page: Int = 1
    @State var height: Float = 170
    @State var weight: Float = 70
    @State var age: Float = 20
    @State var workoutTime: Float = 0.0
    
    
    
    var body: some View {
        PageOneView(name: "")
    }
}

#Preview {
    SetUpManager(name: .constant("Advait"))
}

