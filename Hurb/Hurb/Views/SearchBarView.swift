//
//  SearchBarView.swift
//  Hurb
//
//  Created by Arthur Givigir on 1/2/21.
//

import SwiftUI

struct SearchBarView: View {
    @ObservedObject var hotelListViewModel: HotelListViewModel
    
    @State var array: [String] = []
    @State private var showCancelButton: Bool = false
    
    var body: some View {
        VStack {
            HStack {
                HStack {
                    Image(systemName: "magnifyingglass")

                    TextField("Buscar por cidade",
                              text: self.$hotelListViewModel.searchByCity,
                              onEditingChanged: { isEditing in
                                self.showCancelButton = true
                    }, onCommit: {
                        print("onCommit")
                        self.array = []
                    })
                    .foregroundColor(.primary)
                        .onReceive(self.hotelListViewModel.$searchByCity.debounce(for: 0.8, scheduler: RunLoop.main)) { teste in
                        
                    }

                    Button(action: {
                        self.hotelListViewModel.searchByCity = ""
                    }) {
                        Image(systemName: "xmark.circle.fill").opacity(self.hotelListViewModel.searchByCity == "" ? 0 : 1)
                    }
                }
                .padding(EdgeInsets(top: 10, leading: 5, bottom: 10, trailing: 5))
                .foregroundColor(.secondary)
                .cornerRadius(10.0)
            }
            .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
            
            if !array.isEmpty {
                List {
                    // Filtered list of names
                    ForEach(array, id:\.self) { searchText
                        in Text(searchText)
                    }
                    .listRowBackground(Color.white)
                }
                .background(Color.clear)
                .listStyle(InsetGroupedListStyle())
                .resignKeyboardOnDragGesture()
            }
            
        }
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarView(hotelListViewModel: HotelListViewModel())
    }
}


extension UIApplication {
    func endEditing(_ force: Bool) {
        self.windows
            .filter{$0.isKeyWindow}
            .first?
            .endEditing(force)
    }
}

struct ResignKeyboardOnDragGesture: ViewModifier {
    var gesture = DragGesture().onChanged{_ in
        UIApplication.shared.endEditing(true)
    }
    func body(content: Content) -> some View {
        content.gesture(gesture)
    }
}

extension View {
    func resignKeyboardOnDragGesture() -> some View {
        return modifier(ResignKeyboardOnDragGesture())
    }
}
