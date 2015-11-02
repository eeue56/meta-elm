module Meta where

import Native.Meta

nameOf : a -> String
nameOf =
    Native.Meta.nameOf

switchType : a -> b -> b
switchType =
    Native.Meta.switchType
