//
//  Recipes.swift
//  (name)
//
//  Created by Stoyan Nikolov on 20.05.24.
//

import Foundation

struct Recipes<RecipeContent> {
    struct Recipe: Identifiable{
        let id: Int
        let image: RecipeContent
        let name: RecipeContent
        var showDetails: Bool = false
        let filter: Filter
        let text: RecipeContent
    }
    
    enum Filter {
        case salad, soup, main, fastfood, bread, dessert
    }
    
    private(set) var recipes: Array<Recipe>
    private(set) var chosenRecipes: Array<Recipe> = []
    
    var isSearching: Bool = false
    var isFiltering: Bool = false
    var isCarting: Bool = false
    
    init(names: Array<RecipeContent>, images: Array<RecipeContent>, filters: Array<Filter>, texts: Array<RecipeContent>) {
        recipes=[]
        for i in 0..<min(names.count, images.count) {
            recipes.append(Recipe(id: i, image: images[i], name: names[i], filter: filters[i], text: texts[i]))
        }
    }
    
    mutating func search() {
        isSearching = !isSearching
    }
    
    mutating func showMoreDetails(_ recipe: Recipe)
    {
        if let chosenIndex = recipes.firstIndex(where: { $0.id==recipe.id }) {
            recipes[chosenIndex].showDetails = !recipes[chosenIndex].showDetails
        }
    }
    
    mutating func filter() {
        isFiltering = !isFiltering
    }
    
    mutating func cart() {
        isCarting = !isCarting
    }
    
    mutating func addRecipe(_ recipe: Recipe) {
        chosenRecipes.append(recipe)
    }
    
    mutating func clear() {
        chosenRecipes = []
    }
    
    mutating func clearRecipe(_ recipe: Recipe) {
        if let chosenIndex = chosenRecipes.firstIndex(where: {$0.id==recipe.id}) {
            chosenRecipes.remove(at: chosenIndex)
        }
    }
}
