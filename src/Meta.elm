module Meta where

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


--getter : (a -> b) -> String -> a
getter =
    Native.Meta.getter
