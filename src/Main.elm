import Meta
import Graphics.Element exposing (show)

import Html exposing (div)

type Sausage = Empty | Sausage Int

type Animal = Cat | Dog
type Fish = Fish (Maybe Int)

type alias Naughty = {
    ctor : String
}

naught =
    { ctor = "Nothing"
    }



n = Meta.banana <| Sausage 5

myCat =
    Cat

myCatIsADog =
    Meta.switchType myCat Dog

isMyCatReallyADog =
    case myCatIsADog of
        Dog -> "Yup, he's a dog!"
        Cat -> "Nope, he's a cat."

myDogCatIsNowAFish =
    Meta.switchType myCatIsADog (Fish (Just 1))

isMyDogCatReallyAFish =
    case myDogCatIsNowAFish of
        Fish _ -> "Yup, fishy!"

age =
    Just 5

newAge =
    Meta.fmap (\x -> x + 1) age

type Age = Years Int | Days Int

newNewAge =
    Meta.fmap (\x -> x + 5) <| Years 5


type alias Person = {
    age : Int,
    name : String,
    realAge : Int,
    actualAge : Meta.Getter Int
}

me =
    { name = "Dave"
    , age = 12
    , realAge = 21
    , actualAge = Meta.Getter 0
    }

me' =
    Meta.getter
        (\me -> if me.age < 20 then me.realAge else me.age)
        me.actualAge
        me

iAmTwelveAndWhatIsThis =
    Meta.switchType me me

iAmTwelveAndWhatIsMyAgeAgain =
    me'.actualAge

letsSee : Person -> String
letsSee person =
    (toString person.actualAge) ++ "!"

me'' =
    { me' | age = 30 }

me''' =
    { me'' | age = 31 }


type Action = Noop | Run | Robot

update action model =
    case action of
        Run ->
            model
        Robot ->
            model
        Noop ->
            model

main =
    show <| Meta.allPossibleActions update
