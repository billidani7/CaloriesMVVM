## MVVM pattern

<p align="center">
<img src="screen-1.png" width="280"> 
<img src="screen-2.png" width="280" hspace="20">
<img src="screen-3.png" width="280">
</p>



The _Model-View-ViewModel_ (MVVM) pattern is a UI design pattern. It’s a member of a larger family of patterns collectively known as _MV*_, these include [Model View Controller](http://en.wikipedia.org/wiki/Model%E2%80%93view%E2%80%93controller) (MVC), [Model View Presenter](http://en.wikipedia.org/wiki/Model%E2%80%93view%E2%80%93presenter) (MVP) and a number of others.

Each of these patterns addresses separating UI logic from business logic in order to make apps easier to develop and test.

MVVM programming with View Models is the new pattern that Apple is recommending developers follow after WWDC this year.


![enter image description here](https://i.ibb.co/H4HbJqt/MVVMPattern.png)

 _ViewModel_, is a special type of model that represents the UI state of the app. For example, it holds the current text of a text field or the items of a List.

### MVVM basic rules
MVVM pattern is following these strict rules:
1.  The View has a reference to the ViewModel, but not vice-versa.
2.  The ViewModel has a reference to the Model, but not vice-versa.
3.  The View has no reference to the Model or vice-versa.


Let’s consider a quick example of the MVVM module for a SwiftUI app. We will create a view with a text field and a List. Users would type a food name in the text field and the results would be shown in the List.

We will start with the model layer and move upwards to the UI.

### Model
```swift
struct Food: Codable {
	name: String
}
```

### View Model
```swift
// 1
class AddMealViewModel: ObservableObject {
	// 2
    @Published var searchText = ""
    @Published var foodResults: [Food] = []
	
	private var searchCancellable: AnyCancellable? {
        willSet {
            searchCancellable?.cancel()
        }
    }
    
    private var disposables = Set<AnyCancellable>()

	init() {
		//3
        $searchText
            .dropFirst(1) //4
            //5
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main) 
            .sink(receiveValue: searchAction(forFood:)) //6
            .store(in: &disposables) //7
    }
}
```
1. `ObservableObject` is a protocol that’s part of the **Combine** framework. It is used within a custom class/model to keep track of the state.

2. `@Published` is one of the most useful property wrappers in SwiftUI, allowing us to create observable objects that automatically announce when changes occur. Because the property is marked `@Published`, the compiler automatically synthesizes a publisher for it. SwiftUI subscribes to that publisher and and re-invoke the `body` property of any views that rely on the data.

3. The  `searchText`  property uses the  `@Published`  property wrappers so it acts like any other  `Publisher`. This means it can be observed and can also make use of any other method that is available to  `Publisher`.

4. When you create the observation,  `$searchText`  emits its first value. Since the first value is an empty string, you should skip it to avoid an unintended network call.

5. Use  `debounce(for:scheduler:)`  to provide a better user experience. Without it the  `searchAction` function would make a new HTTP request for every letter typed.  `debounce`works by waiting half a second (`0.5`) until the user stops typing and finally sending a value.

6. The  `searchText`  changes been observed by `sink(receiveValue:)`  and the  `searchAction(forFood:)` function executes an API call.

7.  Think of  `disposables`  as a collection of references to requests. Without keeping these references, the network requests you’ll make won’t be kept alive, preventing you from getting responses from the server.

### View
```swift
struct AddMealView: View {
	//1
    @ObservedObject var viewModel: AddMealViewModel
    
    var body: some View {
        
        VStack {
	        //2 
            TextField("Search food", text: $viewModel.searchText)
            
            List(viewModel.foodResults) { food in
                Text(food.name)
            }
        }
    }
}
```
1. ObservedObject is a property wrapper type that subscribes to an observable object and invalidates a view whenever the observable object changes. In other words, when the `AddMealViewModel` changes, the view will observe its changes.

2. `$viewModel.searchText` establishes a connection between the values you’re typing in the `TextField` and the `AddMealViewModel`‘s `searchText` property. Using `$`allows you to turn the `searchText` property into a `Binding<String>`. This is only possible because `AddMealViewModel` conforms to `ObservableObject` and is declared with the `@ObservedObject` property wrapper.
