import Meta
import Graphics.Element exposing (show)


type Animal = Cat | Dog
type Fish = Fish (Maybe Int)

myCat =
    Cat

myCatIsADog =
    Meta.switchType myCat Dog

isMyCatReallyADog =
    case myCatIsADog of
        Dog -> "Yup, he's a dog!"
        Cat -> "Nope, he's a cat."
        _ -> "IDK what he is."

myDogCatIsNowAFish =
    Meta.switchType myCatIsADog (Fish (Just 1))

isMyDogCatReallyAFish =
    case myDogCatIsNowAFish of
        Fish _ -> "Yup, fishy!"
        _ -> "Nope, something else"

age =
    Just 5

newAge =
    Meta.fmap (\x -> x + 1) age

type Age = Years Int | Days Int

newNewAge =
    Meta.fmap (\x -> x + 5) <| Years 5


main = show <| newNewAge
