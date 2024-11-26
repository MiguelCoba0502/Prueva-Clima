//
//  SearchBar.swift
//  Prueva Clima
//
//  Created by Eduardo Coba on 12/11/24.
//

import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    var onSearch: () -> Void
    
    var body: some View {
        HStack{
            TextField("Search city", text: $text)
                .padding(.leading,10)
                .frame(height: 10)
                .foregroundColor(.white)
            
            Button(action: { 
                onSearch()
            }){
            Image(systemName: "magnifyingglass")
                    .padding(6)
            }
            .padding(.leading, -20)
            .frame(width: 40, height: 40)
            
            .cornerRadius(8)
            .foregroundColor(.white)
        }
        .background(Color(.systemGray3))
        .cornerRadius(20)
        .padding()
    }
}

#Preview {
    SearchBar(text: .constant("Morelia")){
        print("Search.......")
    }
}
