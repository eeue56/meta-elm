import Meta exposing (..)
import Graphics.Element exposing (show)

import Task exposing (Task)

import Html exposing (div)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Effects
import StartApp

type Sausage = Empty | Sausage Int

type Animal = Cat | Dog
type Fish = Fish (Maybe Int)

type alias Naughty = {
    ctor : String
}

naught =
    { ctor = "Nothing"
    }

type alias User =
    { name : String
    , age : LazyLoad Int
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


type Action = Noop | Run | Robot | TriggerLoad User

update action model =
    case action of
        Run ->
            (model, Effects.none)
        Robot ->
            (model, Effects.none)
        Noop ->
            (model, Effects.none)
        TriggerLoad user ->
            let
                trigger =
                    triggerLoad user.age
                        |> (flip Task.andThen) (\_ -> Task.succeed Noop)
            in
            (model, Effects.task trigger)

viewUser : Signal.Address Action -> User -> Html.Html
viewUser addr user =
    let
        extras =
            case user.age of
                Waiting ->
                    [ Html.text " age not loaded yet"]
                Loaded age ->
                    [ Html.text <| " and they are " ++ (toString age) ++ " years old" ]
    in
        div
            [ onClick addr (TriggerLoad user)]
            ([ div [] [Html.text ("Click to load this user\n\n")]
             , Html.text ("Name: " ++user.name)
            ] ++ extras)

view : Signal.Address Action -> List User -> Html.Html
view addr users =
    div
        []
        (List.map (viewUser addr) users)

nf : Int -> Task String Int
nf n =
    Task.sleep 1000
        |> (flip Task.andThen) (\_ -> Task.succeed n)

users =
    [
        { name = "noah"
        , age = create 5 (nf 23)
        }
    ,
        { name = "dave"
        , age = create 5 (nf 32)
        }
    ]


app =
    StartApp.start { init = (users, Effects.none), view = view, update = update, inputs = [] }

main =
    app.html

port tasks : Signal (Task.Task Effects.Never ())
port tasks =
    app.tasks
