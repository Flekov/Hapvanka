//
//  ContentView.swift
//  (name)
//
//  Created by Stoyan Nikolov on 9.05.24.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var menu: RecipesViewModel
    
    @State var searchText: String = ""
    @Namespace private var searchingNameSpace
    
    @State var currentFilter: Recipes<String>.Filter? = nil
    
    var filter: some View {
        Button {
            withAnimation {
                menu.filter()
            }
        } label: {
            ZStack {
                Circle()
                    .foregroundColor(Color("Pinkk"))
                //.padding(.horizontal, 70)
                switch currentFilter {
                case .salad:
                    Text("Салати")
                        .foregroundColor(.white)
                        .font(.custom("BrushType Normal", size: 25))
                case .soup:
                    Text("Супи")
                        .foregroundColor(.white)
                        .font(.custom("BrushType Normal", size: 28))
                case .main:
                    Text("Основни")
                        .foregroundColor(.white)
                        .font(.custom("BrushType Normal", size: 23))
                case .fastfood:
                    Text("Брънч")
                        .foregroundColor(.white)
                        .font(.custom("BrushType Normal", size: 28))
                case .bread:
                    Text("Печива")
                        .foregroundColor(.white)
                        .font(.custom("BrushType Normal", size: 25))
                case .dessert:
                    Text("Десерти")
                        .foregroundColor(.white)
                        .font(.custom("BrushType Normal", size: 23))
                case nil:
                    Text("Всичко")
                        .foregroundColor(.white)
                        .font(.custom("BrushType Normal", size: 25))
                }
            }
        }
        //.padding(.horizontal, 70)
        //.position(CGPoint(x: 60, y: 0))
        .aspectRatio(6/1, contentMode: .fit)
    }
    
    var search: some View {
        Button {
            withAnimation {
                menu.search()
            }
        } label: {
            ZStack {
                Circle()
                    .foregroundColor(Color("Pinkk"))
                //.padding(.horizontal, 70)
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.white)
                    .font(.largeTitle)
            }
        }
        //.padding(.horizontal, 70)
        //.position(CGPoint(x: 200, y: 0))
        .aspectRatio(6/1, contentMode: .fit)
    }
    
    var account: some View {
        Button {
            withAnimation {
                
            }
        } label: {
            ZStack {
                Circle()
                    .foregroundColor(Color("Pinkk"))
                //.padding(.horizontal, 70)
                Image(systemName: "line.3.horizontal")
                    .foregroundColor(.white)
                    .font(.largeTitle)
            }
        }
        //.padding(.horizontal, 70)
        //.position(CGPoint(x: 60, y: 0))
        .aspectRatio(6/1, contentMode: .fit)
    }
    
    var cart: some View {
        Button {
            withAnimation {
                menu.cart()
            }
        } label: {
            ZStack {
                Circle()
                    .foregroundColor(Color("Pinkk"))
                //.padding(.horizontal, 70)
                Image(systemName: "cart")
                    .foregroundColor(.white)
                    .font(.custom("BrushType Normal", size: 35))
            }
        }
        //.padding(.horizontal, 70)
        //.position(CGPoint(x: 60, y: 0))
        .aspectRatio(6/1, contentMode: .fit)
    }
    
    var body: some View {
        ZStack {
            Color(.white)
                .edgesIgnoringSafeArea(.all)
            ScrollView {
                ForEach(menu.recipes) { recipe in
                    if((currentFilter == nil || recipe.filter == currentFilter) &&
                       (searchText == "" || recipe.name.lowercased().contains(searchText.lowercased()))) {
                        VStack {
                            RecipeView(recipe: recipe)
                                .onTapGesture {
                                    withAnimation {
                                        menu.showMoreDetails(recipe)
                                    }
                                }
                            ZStack {
                                Text(recipe.name)
                                    .font(.custom("BrushType Normal", size: 25))
                                    .foregroundColor(.black)
                                //.padding(.horizontal, 70)
                                    .position(CGPoint(x: 130, y: 25))
                                Button {
                                    withAnimation {
                                        menu.addRecipe(recipe)
                                    }
                                } label: {
                                    ZStack {
                                        Circle()
                                            .foregroundColor(Color("Sky"))
                                        //.padding(.horizontal, 70)
                                        Image(systemName: "plus")
                                            .font(.largeTitle)
                                            .foregroundColor(.white)
                                    }
                                }
                                //.padding(.horizontal, 70)
                                .position(CGPoint(x: 290, y: 0))
                                .aspectRatio(6/1, contentMode: .fill)
                            }
                        }
                        .position(x: 197, y: 145)
                    }
                }
                Circle().foregroundColor(.white)
            }
            .position(CGPoint(x: 197, y: 420))
            
            
            Arch()
                .edgesIgnoringSafeArea(.all)
                .frame(width: 400, height: 400)
                .foregroundColor(Color("Peach"))
                .position(x: 198,y: 40) // 40
            VStack {
                if !menu.isSearching {
                    search
                        .transition(.scale)
                } else {
                    search
                        .opacity(0)
                }
                ZStack {
                    filter
                        .position(CGPoint(x: 60, y: 10)) //10
                    account
                        .position(CGPoint(x: 335, y: 10))
                }
                Spacer()
                cart.padding(.bottom)
            }
            if menu.isSearching {
                Color.black
                    .opacity(0.4)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        withAnimation {
                            menu.search()
                        }
                    }
                searchBar
                    .transition(.opacity)
                
            }
            
            if let chosenIndex = menu.recipes.firstIndex(where: { $0.showDetails==true }) {
                recipeDetails(chosenIndex)
                    .transition(.opacity)
            }
            
            if menu.isFiltering {
                filtersView
            }
                 
            if menu.isCarting {
                cartView
            }
            
        }
    }
    
    struct RecipeView: View {
        var recipe: RecipesViewModel.Recipe
        
        var body: some View {
            Image(recipe.image)
                .resizable()
                .aspectRatio(2/1, contentMode: .fill)
                .frame(width: 150, height: 150)
                .clipShape(SemiCircle())
                //.padding(.top)
                .shadow(color: .black, radius: 10)
            
        }
    }
    
    var searchBar: some View {
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .foregroundColor(.white)
                    .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color("Pinkk"), lineWidth: 2))
                HStack {
                    Image(systemName: "magnifyingglass")
                        .font(.title)
                        .foregroundColor(Color("Pinkk"))
                    TextField("Какво ти се хапва?", text: $searchText)
                        .font(.custom("BrushType Normal", size: 22))
                        .padding(7)
                        .background(.white)
                        .cornerRadius(8)

                    if !searchText.isEmpty {
                        Button {
                            searchText = ""
                        } label: {
                            Image(systemName: "xmark.circle")
                                .padding(.trailing, 8)
                                .font(.title)
                                .foregroundColor(Color("Pinkk"))
                        }
                    }
                }
                .padding()
            }
            .aspectRatio(5/1,contentMode: .fit)
            .padding(.all)
            .padding(.top)
                
            Spacer()
        }
    }

    private func recipeDetails(_ index: Int) -> some View {
        ZStack {
            Color.black.opacity(0.4)
                .edgesIgnoringSafeArea(.all)
            ZStack {
                RoundedRectangle(cornerRadius: 25.0)
                    .foregroundColor(.white)
                    .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color("Pinkk"), lineWidth: 2))
                VStack{
                    Text(menu.recipes[index].name)
                        .font(.custom("BrushType Normal", size: 25))
                        .padding(.top)
                    RecipeView(recipe: menu.recipes[index])
                    ScrollView{
                        Text(menu.recipes[index].text)
                            .font(.custom("BrushType Normal", size: 25))
                            .padding()
                    }
                }
                VStack {
                    HStack {
                        Button {
                            withAnimation{
                                menu.showMoreDetails(menu.recipes[index])
                            }
                        } label: {
                            Text("Назад")
                                .foregroundColor(Color("Pinkk"))
                                .font(.custom("BrushType Normal", size: 25))
                        }
                        Spacer()
                    }
                    .padding()
                    Spacer()
                }
                
            }
            .padding()
        }
    }
    
    let filters: Array<Recipes<String>.Filter> = [.salad, .soup, .fastfood, .main, .bread, .dessert]
    let filtersNames: Array<String> = ["Салати", "Супи", "Брънч", "Основни", "Печива", "Десерти"]
    
    var filtersView: some View{
        ZStack {
            Color.black.opacity(0.4)
                .edgesIgnoringSafeArea(.all)
            ZStack {
                RoundedRectangle(cornerRadius: 25.0)
                    .foregroundColor(.white)
                    .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color("Pinkk"), lineWidth: 2))
                    .aspectRatio(2/2, contentMode: .fit)
                VStack {
                    HStack {
                        Button {
                            withAnimation{
                                menu.filter()
                            }
                        } label: {
                            Text("Назад")
                                .foregroundColor(Color("Pinkk"))
                                .font(.custom("BrushType Normal", size: 25))
                        }
                        .padding(.leading)
                        //.padding(.bottom)
                        Spacer()
                    }
                    //.padding()
                    Text("Хапванки")
                        .font(.custom("BrushType Normal", size: 35))
                        .padding(.bottom)
                    ForEach(filters, id: \.self) { filter in
                        filterButtonView(filter)
                    }
                }
               // VStack {
                    /*HStack {
                        Button {
                            withAnimation{
                                menu.filter()
                            }
                        } label: {
                            Text("Назад")
                                .foregroundColor(Color("Pinkk"))
                                .font(.custom("BrushType Normal", size: 25))
                        }
                        Spacer()
                    }
                    .padding()*/
                //}
                
            }
            .padding()
        }
    }
    
    private func filterButtonView(_ filter: Recipes<String>.Filter) -> some View{
        Button {
            withAnimation{
                if (currentFilter == filter) {
                    currentFilter = nil
                } else {
                    currentFilter = filter
                }
                //menu.filter()
            }
        } label: {
            if (currentFilter == filter) {
                HStack {
                    Image(systemName: "checkmark.square.fill")
                        .font(.custom("BrushType Normal", size: MagicNumbers.filtersTextSize))
                        .foregroundColor(Color("Pinkk"))
                        
                    switch filter {
                    case .bread:
                        Text("Печива")
                            .font(.custom("BrushType Normal", size: MagicNumbers.filtersTextSize))
                            .foregroundColor(Color("Pinkk"))
                    case .salad:
                        Text("Салати")
                            .font(.custom("BrushType Normal", size: MagicNumbers.filtersTextSize))
                            .foregroundColor(Color("Pinkk"))
                    case .soup:
                        Text("Супи")
                            .font(.custom("BrushType Normal", size: MagicNumbers.filtersTextSize))
                            .foregroundColor(Color("Pinkk"))
                    case .main:
                        Text("Основни")
                            .font(.custom("BrushType Normal", size: MagicNumbers.filtersTextSize))
                            .foregroundColor(Color("Pinkk"))
                    case .fastfood:
                        Text("Брънч")
                            .font(.custom("BrushType Normal", size: MagicNumbers.filtersTextSize))
                            .foregroundColor(Color("Pinkk"))
                    case .dessert:
                        Text("Десерти")
                            .font(.custom("BrushType Normal", size: MagicNumbers.filtersTextSize))
                            .foregroundColor(Color("Pinkk"))
                    }
                    Spacer()
                }
                .padding(.horizontal)
            } else {
                HStack {
                    Image(systemName: "square")
                        .font(.custom("BrushType Normal", size: MagicNumbers.filtersTextSize))
                        .foregroundColor(Color("Pinkk"))
                        
                    switch filter {
                    case .bread:
                        Text("Печива")
                            .font(.custom("BrushType Normal", size: MagicNumbers.filtersTextSize))
                            .foregroundColor(Color("Pinkk"))
                    case .salad:
                        Text("Салати")
                        .font(.custom("BrushType Normal", size: MagicNumbers.filtersTextSize))
                            .foregroundColor(Color("Pinkk"))
                    case .soup:
                        Text("Супи")
                            .font(.custom("BrushType Normal", size: MagicNumbers.filtersTextSize))
                            .foregroundColor(Color("Pinkk"))
                    case .main:
                        Text("Основни")
                            .font(.custom("BrushType Normal", size: MagicNumbers.filtersTextSize))
                            .foregroundColor(Color("Pinkk"))
                    case .fastfood:
                        Text("Брънч")
                            .font(.custom("BrushType Normal", size: MagicNumbers.filtersTextSize))
                            .foregroundColor(Color("Pinkk"))
                    case .dessert:
                        Text("Десерти")
                            .font(.custom("BrushType Normal", size: MagicNumbers.filtersTextSize))
                            .foregroundColor(Color("Pinkk"))
                    }
                    Spacer()
                }
                .padding(.horizontal)
            }
        }
    }
    
    var cartView: some View {
        ZStack {
            Color.black.opacity(0.4)
                .edgesIgnoringSafeArea(.all)
            ZStack {
                RoundedRectangle(cornerRadius: 25.0)
                    .foregroundColor(.white)
                    .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color("Pinkk"), lineWidth: 2))
                ScrollView{
                    ForEach(menu.chosenRecipes) { recipe in
                        ZStack {
                            RoundedRectangle(cornerRadius: 25.0)
                                .foregroundColor(.white)
                                .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color("Pinkk"), lineWidth: 2))
                                .aspectRatio(3/1,contentMode: .fit)
                            HStack {
                                Text(recipe.name)
                                    .font(.custom("BrushType Normal", size: 20))
                                    .padding()
                                Image(recipe.image)
                                    .resizable()
                                    .aspectRatio(2/1, contentMode: .fill)
                                    .frame(width: 130, height: 80)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                    .shadow(color: .black, radius: 10)
                                Spacer()
                                Button {
                                    withAnimation {
                                        menu.clearRecipe(recipe)
                                    }
                                } label: {
                                    Image(systemName: "xmark.circle")
                                        .padding(.trailing, 8)
                                        .font(.title)
                                        .foregroundColor(Color("Pinkk"))
                                }
                            }
                        }
                        .padding(.top)
                    }
                }
                .padding()
                .padding(.top)
                VStack {
                    HStack {
                        Button {
                            withAnimation{
                                menu.cart()
                            }
                        } label: {
                            Text("Назад")
                                .foregroundColor(Color("Pinkk"))
                                .font(.custom("BrushType Normal", size: 25))
                        }
                        Spacer()
                        Button {
                            withAnimation{
                                menu.clear()
                            }
                        } label: {
                            Text("Изчисти")
                                .foregroundColor(Color("Pinkk"))
                                .font(.custom("BrushType Normal", size: 25))
                        }
                    }
                    .padding()
                    Spacer()
                }
                
            }
            .padding()
        }
    }
    
    private struct MagicNumbers {
        static let filtersTextSize: CGFloat = 30
    }
}


#Preview {
    let menu = RecipesViewModel()
    return ContentView(menu: menu)
}
