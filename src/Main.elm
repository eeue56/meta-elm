import Meta
import Graphics.Element exposing (show)


type Animal = Cat | Dog
type Fish = Fish

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
    Meta.switchType myCatIsADog Fish

isMyDogCatReallyAFish =
    case myDogCatIsNowAFish of
        Fish -> "Yup, fishy!"
        _ -> "Nope, something else"

main = show <| isMyDogCatReallyAFish
