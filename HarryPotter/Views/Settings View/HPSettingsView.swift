//
//  HPSettingsView.swift
//  HarryPotter
//
//  Created by Charity Funtila on 9/29/23.
//

import SwiftUI

struct HPSettingsView: View {
    
    let cellViewModels: [HPSettingsCellViewModel]
    let viewModel: HPSettingsViewViewModel
    
    init(viewModel: HPSettingsViewViewModel) {
        self.viewModel = viewModel
        self.cellViewModels = viewModel.cellViewModels
    }
    
    
    var body: some View {
        List(cellViewModels) { viewModel in
            HStack {
                if let image = viewModel.image {
                    Image(uiImage: image)
                        .resizable()
                        .renderingMode(.template)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20, height: 20)
                        .padding(10)
                        .background(Color(viewModel.iconContainerColor))
                        .cornerRadius(6)
                }
                Text(viewModel.title)
                    .padding(.leading, 10)
                Spacer()
            }.padding()
                .onTapGesture {
                    viewModel.onTapHandler(viewModel.type)
                }
        }
    }
}

struct HPSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        HPSettingsView(viewModel: HPSettingsViewViewModel(cellViewModels: HPSettingsOption.allCases.compactMap({ option in
            return HPSettingsCellViewModel(type: option) { option in
                 
            }
        })))
    }
}
