# meta-elm

Welcome to meta-elm! In here, we will look at examples of how to abuse Elm to make it work for meta-programming. Note the word _abuse_. Don't do any of this for anything other than research or experiments!

For example, a implementation of fmap:

```elm
age =
    Just 5

-- equal to 6
newAge =
    Meta.fmap (\x -> x + 1) age

-- equal to Nothing
newerAge =
    Meta.fmap (\x -> x + 1) Nothing

type Age = Years Int | Days Int

-- equal to Years 10
newNewAge =
    Meta.fmap (\x -> x + 5) <| Years 5
```

Or how about changing the type of an object at runtime:

```elm

type Animal = Cat | Dog
type Fish = Fish (Maybe Int)

myCat =
    Cat

-- equal to Dog
myCatIsADog =
    Meta.switchType myCat Dog

-- equal to "Yup, he's a dog"
isMyCatReallyADog =
    case myCatIsADog of
        Dog -> "Yup, he's a dog!"
        Cat -> "Nope, he's a cat."
        _ -> "IDK what he is."

-- equal to Fish _
myDogCatIsNowAFish =
    Meta.switchType myCatIsADog (Fish (Just 1))

-- equal to "Yup, fishy!"
isMyDogCatReallyAFish =
    case myDogCatIsNowAFish of
        Fish _ -> "Yup, fishy!"
        _ -> "Nope, something else"

```

Use getters for self-referential properties

```elm

type alias Person = {
    age : Int,
    name : String,
    realAge : Int,
    actualAge : Meta.Getter Int
}

-- need to provide a default value for the getter
me = {
    name = "Dave",
    age = 12,
    realAge = 21,
    actualAge = Meta.Getter -1 }

-- create a getter on the me object
me' =
    Meta.getter
        (\me -> if me.age < 20 then me.realAge else me.age)
        me.actualAge
        me

-- equal to 21
myAge =
    me'.actualAge

```
