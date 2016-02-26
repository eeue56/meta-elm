module Meta where

import Json.Encode exposing (string)
import VirtualDom exposing (Node, property)

import Native.Meta

nameOf : a -> String
nameOf =
    Native.Meta.nameOf

switchType : a -> b -> b
switchType =
    Native.Meta.switchType

fmap : a -> b -> b
fmap =
    Native.Meta.fmap


allPossibleActions : (a -> b) -> List a
allPossibleActions =
    Native.Meta.allPossibleActions



type Getter a =
    Getter a


-- we have to abuse the type system a bit here..
-- not really very fond of it
-- but in order to get it to compile,
-- we have to refuse to acknowledge the record
-- type that we're passing in, as otherwise it blows up
-- it's possible to override this implementation
-- within your own modules and provide a type signature to
-- back up the compile system
getter : (a -> b) -> Getter b -> a -> a
getter f g record =
    Native.Meta.getter f g record


style : String -> VirtualDom.Node
style text =
    VirtualDom.node
        "style"
        [ property "textContent" <| string text
        , property "type" <| string "text/css" ]
        []

banana : a -> a
banana =
    Native.Meta.banana
