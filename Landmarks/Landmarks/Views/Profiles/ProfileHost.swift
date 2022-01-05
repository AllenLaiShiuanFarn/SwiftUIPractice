//
//  ProfileHost.swift
//  Landmarks
//
//  Created by allenlai on 2022/1/5.
//

import SwiftUI

struct ProfileHost: View {
    @State private var draftProfile = Profile.default
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Profile for: \(draftProfile.username)")
        }
        .padding()
    }
}

struct ProfileHost_Previews: PreviewProvider {
    static var previews: some View {
        ProfileHost()
    }
}
