Elm.Native.Meta = {};
Elm.Native.Meta.make = function(localRuntime) {
    localRuntime.Native = localRuntime.Native || {};
    localRuntime.Native.Meta = localRuntime.Native.Meta || {};
    if (localRuntime.Native.Meta.values)
    {
        return localRuntime.Native.Meta.values;
    }

    $Native$Show = Elm.Native.Show.make(localRuntime);
    var _toString = $Native$Show.toString;


    var nameOf = function nameOf(obj){
        return obj.ctor;
    };

    var switchType = function switchType(left, right){
        left.ctor = right.ctor;
        return left;
    };


    return Elm.Native.Meta.values = {
        nameOf: nameOf,
        switchType: F2(switchType)
    };
};
